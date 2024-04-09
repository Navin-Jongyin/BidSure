import 'dart:convert';
import 'package:bidsure_2/components/my_AppBar.dart';
import 'package:bidsure_2/components/my_bottomNavBar.dart';
import 'package:bidsure_2/components/newAuction_Modal.dart';
import 'package:bidsure_2/components/palette.dart';
import 'package:bidsure_2/pages/home_Page.dart';
import 'package:bidsure_2/pages/profile_Page.dart';
import 'package:bidsure_2/pages/wallet_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _filteredCategories = [];
  List<String?> _filteresFullname = [];
  List<String?> _filteredImagePaths = [];
  String imageUrl = "";
  List<String?> _filteredUserBio = [];
  List<String?> _filteredUserId = [];
  String userId = "";
  String allUser = "";
  List<String> followID = [];
  SharedPreferences? prefs;
  List<String?> followingNumbers = [];
  List<String?> followerNumbers = [];

  @override
  void initState() {
    super.initState();
    getData();
    _filterUser('');
  }

  void getData() async {
    String apiUrl = "http://192.168.1.43:3000/user/alluseridandusername";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final id = jsonData['id'];
      allUser = jsonData;
      setState(
        () {
          print(response.body);
          print(id);
          print(jsonData);
        },
      );
    }
    // Initialize SharedPreferences
    prefs = await SharedPreferences.getInstance();
    // Retrieve followed user IDs from SharedPreferences
    followID = prefs!.getStringList('followedIDs') ?? [];
  }

  Future<void> getfollowing() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      String apiUrl = 'http://192.168.1.43:3000/user/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final baseUrl = 'http://192.168.1.43:3000';
        final jsonData = jsonDecode(response.body);
        final List<dynamic> following = jsonData['following'];
        final List<dynamic> follower = jsonData['follower'];
        final List<String> followingNumber =
            following.map((item) => item.toString()).toList();
        final List<String> followerNumber =
            follower.map((item) => item.toString()).toList();

        print(followingNumber.length);

        setState(() {
          followingNumbers = followingNumber;
          followerNumbers = followerNumber;
        });
      } else {
        print("failed");
        print(response.statusCode);
      }
    }
  }

  void followUser(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = "http://192.168.1.43:3000/user/follow";
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'follow': userId}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      // Successfully followed the user, handle accordingly
      print("Successfully followed user with ID: $userId");
      // Update local state
      setState(() {
        followID.add(userId);
      });
      // Update SharedPreferences
      prefs.setStringList('followedIDs', followID);
    } else {
      print(response.body);
      // Failed to follow the user, handle accordingly
      print("Failed to follow user with ID: $userId");
    }
  }

  void unfollowUser(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String apiUrl = "http://192.168.1.43:3000/user/unfollow";
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'unfollow': userId}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      // Successfully unfollowed the user, handle accordingly
      print("Successfully unfollowed user with ID: $userId");
      // Update local state
      setState(() {
        followID.remove(userId);
      });
      // Update SharedPreferences
      prefs.setStringList('followedIDs', followID);
    } else {
      print(response.body);
      // Failed to unfollow the user, handle accordingly
      print("Failed to unfollow user with ID: $userId");
    }
  }

  void _filterUser(String query) async {
    if (query.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.get(
        Uri.parse('http://192.168.1.43:3000/user/alluseridandusername?q='),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final baseUrl = 'http://192.168.1.43:3000';
      imageUrl = baseUrl;

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        List<dynamic> userData = data['data'];

        List<String> usernames =
            userData.map((user) => user['username'].toString()).toList();
        List<String?> imagePaths =
            userData.map((user) => user['image'] as String?).toList();
        List<String?> userbio =
            userData.map((user) => user['bio'].toString()).toList();
        List<String> fullname =
            userData.map((user) => user['fullname'].toString()).toList();
        List<String> userId =
            userData.map((user) => user['id'].toString()).toList();

        List<String> filteredUsernames = usernames
            .where((username) =>
                username.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

        List<String?> filteredImagePaths = [];
        List<String?> filteredUserBio = [];
        List<String> filteredFullName = [];
        List<String> filtereduserId = [];

        for (int i = 0; i < usernames.length; i++) {
          if (filteredUsernames.contains(usernames[i])) {
            filteredImagePaths.add(imagePaths[i]);
            filteredUserBio.add(userbio[i]);
            filteredFullName.add(fullname[i]);
            filtereduserId.add(userId[i]);
          }
        }

        setState(() {
          _filteredCategories = filteredUsernames;
          _filteredImagePaths = filteredImagePaths;
          _filteredUserBio = filteredUserBio;
          _filteresFullname = filteredFullName;
          _filteredUserId = filtereduserId;
        });
      } else {
        throw Exception('Failed to load data from API');
      }
    } else {
      setState(() {
        _filteredCategories.clear();
        _filteresFullname.clear();
        _filteredImagePaths.clear();
        _filteredUserBio.clear();
        _filteredUserId.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const MyAppBar(
          appBarTitle: "Search",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterUser,
                  cursorColor: Palette.blueColor,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Palette.greyColor,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Palette.blueColor,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.greyColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(10.0),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.greyColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: _filteredCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        print(_filteredUserBio[index]);
                        print(_filteresFullname[index]);
                        print(_filteredUserId[index]);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Dialog(
                                child: Container(
                                  height: 440,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Palette.whiteColor,
                                  ),
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: _filteredImagePaths[index] !=
                                                null
                                            ? Image.network(
                                                imageUrl +
                                                    _filteredImagePaths[index]!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'icons/avatar.png',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        _filteredCategories[index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "User ID: ${_filteredUserId[index] ?? 'N/A'}", // Display user ID
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Follower",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    color: Palette.blueColor),
                                              ),
                                              Text(
                                                followerNumbers != null
                                                    ? followingNumbers.length
                                                        .toString()
                                                    : "0",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    color:
                                                        Palette.darkGreyColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const VerticalDivider(
                                            color: Palette.greyColor,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Following",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    color: Palette.blueColor),
                                              ),
                                              Text(
                                                followingNumbers != null
                                                    ? followingNumbers.length
                                                        .toString()
                                                    : "0",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    color:
                                                        Palette.darkGreyColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        _filteredUserBio[index] != null
                                            ? _filteredUserBio[index]!
                                            : "",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          String currentUserId =
                                              _filteredUserId[index]!;
                                          if (followID
                                              .contains(currentUserId)) {
                                            // User is already followed, unfollow them
                                            unfollowUser(currentUserId);
                                            setState(() {
                                              followID.remove(currentUserId);
                                            });
                                          } else {
                                            // User is not followed, follow them
                                            followUser(currentUserId);
                                            setState(() {
                                              followID.add(currentUserId);
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: followID.contains(
                                                      _filteredUserId[index])
                                                  ? [
                                                      Colors.red.shade300,
                                                      Palette.redColor
                                                    ]
                                                  : [
                                                      Colors.blue.shade300,
                                                      Palette.blueColor
                                                    ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Center(
                                            child: Text(
                                              followID.contains(
                                                      _filteredUserId[index])
                                                  ? "Unfollow"
                                                  : "Follow",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Palette.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Palette.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Palette.blueColor),
                        ),
                        child: Column(
                          children: [
                            ClipOval(
                              child: _filteredImagePaths[index] != null
                                  ? Image.network(
                                      imageUrl + _filteredImagePaths[index]!,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'icons/avatar.png',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              _filteredCategories[index],
                              style: GoogleFonts.montserrat(
                                color: Palette.darkGreyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          setState(() {});
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
              ),
            );
          } else if (index == 2) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const MyBottomModal();
              },
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const WalletPage(),
              ),
            );
          } else if (index == 4) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}
