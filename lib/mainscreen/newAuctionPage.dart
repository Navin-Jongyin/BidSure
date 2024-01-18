import 'package:bidsure_project/config/palette.dart';
import 'package:bidsure_project/mainscreen/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAuctionPage extends StatefulWidget {
  const CreateAuctionPage({Key? key}) : super(key: key);

  @override
  State<CreateAuctionPage> createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<CreateAuctionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // List of titles corresponding to each tab
  List<String> _tabTitles = ["Create Live Auction", "Create Online Auction"];

  // Text editing controllers for the form fields
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemDescriptionController = TextEditingController();

  // Maximum character limit
  int maxCharacterLimit = 250;
  int maxNameLimit = 25;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabTitles.length,
      vsync: this,
      initialIndex: 0, // Set the initial index
    );

    // Listen to tab changes and update the title accordingly
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.whiteColor,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Palette.darkMainColor,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomePage(),
                  ),
                ); // Close the current page
              },
            ),
            Text(
              _tabTitles[_tabController.index],
              style: GoogleFonts.montserratAlternates(
                fontSize: 20,
                color: Palette.redMainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Content for "Create Live Auction" tab
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _itemNameController,
                    maxLength: maxNameLimit,
                    onChanged: (text) {
                      setState(() {}); // Update UI on text change
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text(
                        "Item Name",
                      ),
                      labelStyle: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _itemDescriptionController,
                    minLines: 5,
                    maxLines: 5,
                    maxLength: maxCharacterLimit,
                    onChanged: (text) {
                      setState(() {}); // Update UI on text change
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text("Item Description"),
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counterText:
                          '${_itemDescriptionController.text.length}/$maxCharacterLimit',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(
                              "Starting Price",
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(
                              "Bid Increase",
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(
                              "Duration",
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(
                              "Start Time",
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 15, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Image"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 120,
                        width: 120,
                        color: Palette.darkMainColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: FloatingActionButton(
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _itemNameController,
                    maxLength: maxNameLimit,
                    onChanged: (text) {
                      setState(() {}); // Update UI on text change
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text(
                        "Item Name",
                      ),
                      labelStyle: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _itemDescriptionController,
                    minLines: 5,
                    maxLines: 5,
                    maxLength: maxCharacterLimit,
                    onChanged: (text) {
                      setState(() {}); // Update UI on text change
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text("Item Description"),
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      counterText:
                          '${_itemDescriptionController.text.length}/$maxCharacterLimit',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(
                              "Starting Price",
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(
                              "Bid Increase",
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 15, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Image"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 120,
                        width: 120,
                        color: Palette.darkMainColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content for "Create Online Auction" tab
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Palette.greyColor.withOpacity(0.2),
        ),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text("Live Auction"),
            ),
            Tab(
              child: Text("Online Auction"),
            ),
          ],
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          labelColor: Palette.redMainColor,
          labelStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: GoogleFonts.montserrat(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of text editing controllers
    _itemNameController.dispose();
    _itemDescriptionController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
