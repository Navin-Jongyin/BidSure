import 'package:bidsure_2/model/live_msg_model.dart';
import 'package:flutter/material.dart';

class LiveMsgProvider extends ChangeNotifier {
  List<LiveMsgModel> _message = [];
  List<LiveMsgModel> get messages => _message;

  void addMessage(LiveMsgModel message) {
    _message.add(message);
    notifyListeners();
  }
}
