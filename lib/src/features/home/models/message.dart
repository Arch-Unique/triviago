import 'package:flutter/material.dart';

class Messages {
  String owner;
  String? desc;
  Color color;
  DateTime time;

  bool get isSentByMe => owner == "Me"; //if owner == current user

  Messages(this.time,
      {this.owner = "Me", this.desc, this.color = Colors.white});
}
