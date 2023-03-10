import 'package:flutter/material.dart';

class Messages {
  String owner;
  String? desc;
  Color color;
  DateTime time;

  Messages(this.time,
      {this.owner = "Me", this.desc, this.color = Colors.white});
}
