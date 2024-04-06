import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String sender;
  final String msg;
  const MessageBox({
    super.key,
    required this.msg,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
