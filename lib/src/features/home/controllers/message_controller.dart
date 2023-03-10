import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:triviago/src/global/services/mypref.dart';
import '../models/message.dart';

class MessageController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  RxList<Messages> allMsg = List.generate(
    10,
    (index) => Messages(DateTime.now().subtract(Duration(hours: 3 * index)),
        owner: index.isEven ? MyPrefs.localUser().username : "MikeMazowski",
        color: userColors[Random().nextInt(userColors.length)],
        desc:
            "Hello guys, we have discussed about post-corona vacation plan and our decision is to go to Bali. "),
  ).obs;
  ScrollController listScrollController = ScrollController();
  Map<String, List<Messages>> get msgs => _getGroupedList(allMsg);

  List<String> get msgKeys => msgs.keys.toList();
  static const List<Color> userColors = [
    Color(0xff7efc67),
    Color(0xffbcfc67),
    Color(0xfffafc67),
    Color(0xfffcc067),
    Color(0xfffc678a),
    Color(0xfffc67c8),
    Color(0xfff267fc),
    Color(0xffb467fc),
  ];

  @override
  onInit() {
    _sortInboxByTime();
    super.onInit();
  }

  addNewMsg() {
    if (textEditingController.value.text.trim().isEmpty) return;
    allMsg.add(Messages(DateTime.now(),
        desc: textEditingController.value.text,
        owner: MyPrefs.localUser().username));
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent +
          listScrollController.position.extentAfter +
          100;
      listScrollController.animateTo(position,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  addNewMsgTriv(Messages l) {
    if (l.desc?.trim().isEmpty ?? true) return;
    allMsg.add(l);
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent +
          listScrollController.position.extentAfter +
          100;
      listScrollController.animateTo(position,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  _sortInboxByTime() {
    allMsg.sort(((a, b) => a.time.compareTo(b.time)));
  }

  Map<String, List<Messages>> _getGroupedList(List<Messages> soms) {
    final groupedInbox = groupBy(soms, (Messages ele) {
      return DateFormat("MMMM d").format(ele.time);
    });
    return groupedInbox;
  }

  List<Messages> getMsg(int i) {
    return msgs[msgKeys[i]]!;
  }
}
