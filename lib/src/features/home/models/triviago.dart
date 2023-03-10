import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviago/src/features/home/controllers/message_controller.dart';
import 'package:triviago/src/features/home/models/message.dart';
import 'package:triviago/src/global/model/questions.dart';
import 'package:triviago/src/global/model/user.dart';
import 'package:triviago/src/src_barrel.dart';

class TriviaGo extends GetxController {
  static User triviago =
      User(username: "TriviaGo", image: "0", id: "0", phone: "0000000000");
  static const demoOptions = ["A", "B", "C", "D"];

  //commands
  static const String ranking = "/ranking"; //my ranking
  static const String point = "/point"; //my total point
  static const String leaderboard = "/leaderboard"; //leaderboard top10
  final controller = Get.find<MessageController>();
  final questions = allQuestions.map((e) => QuizModel.fromMAP(e)).toList();
  RxInt questionNo = 0.obs;
  RxInt messageIndex = 0.obs;
  RxInt prevMessageIndex = 0.obs;
  Map<String, int> leaderboardTable = {};
  Completer ansCompl = Completer();
  Timer? eqr;

  _sendMessage(String msg) {
    controller.addNewMsgTriv(Messages(DateTime.now(),
        owner: triviago.username, color: AppColors.primaryColor, desc: msg));

    prevMessageIndex.value = messageIndex.value;
    messageIndex.value = controller.allMsg.length - 1;
  }

  String generateQuestion() {
    final q = questions[questionNo.value];
    final question = q.question;
    final options = _generateOptions(q.options);
    return "$question\n\n$options";
  }

  onInit() {
    controller.allMsg.listen((p0) {
      if (!ansCompl.isCompleted) {
        handleAnswer(p0.last);
      }
    });
    super.onInit();
  }

  void startGame() {
    final c = generateQuestion();
    _sendMessage(c);
    ansCompl = Completer();
    endQuizAndReset();
  }

  void endQuizAndReset() {
    eqr = Timer(Duration(seconds: 40), () {
      if (ansCompl.isCompleted) {
        resetGame();
        eqr?.cancel();
      } else {
        timeElapsed();
        resetGame();
      }
    });
  }

  void resetGame() {
    questionNo.value += 1;
    Future.delayed(Duration(seconds: 5), () {
      showLeaderboard();
      Future.delayed(Duration(seconds: 5), () {
        startGame();
      });
    });
  }

  handleAnswer(Messages pl) {
    if (pl.desc!.toUpperCase() == questions[questionNo.value].answer) {
      _checkAndScoreUser(pl.owner);
      _sendMessage("Congrats to ${pl.owner}, you got 5 points !!!");
      ansCompl.complete();
      eqr?.cancel();
      resetGame();
    }
  }

  void timeElapsed() {
    List<Messages> f =
        controller.allMsg.sublist(messageIndex.value, controller.allMsg.length);
    for (var i = 0; i < f.length; i++) {
      if (f[i].desc!.toUpperCase() == questions[questionNo.value].answer) {
        _checkAndScoreUser(f[i].owner);
        _sendMessage("Congrats to ${f[i].owner}, you got 5 points !!!");
        ansCompl.complete();
        return;
      }
    }
    ansCompl.complete();
    _sendMessage("Unfortunately, No winner");
  }

  void showLeaderboard() {
    if (leaderboardTable.isEmpty) {
      _sendMessage("No Leaderboard currently");
      return;
    }
    final sortedByValueMap = Map.fromEntries(leaderboardTable.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));
    String sl = "S/N\tName\tScore\n";
    final l = sortedByValueMap.length > 10 ? 10 : sortedByValueMap.length;
    for (var i = 0; i < l; i++) {
      sl +=
          "${i + 1}\t${sortedByValueMap.entries.toList()[i].key}\t${sortedByValueMap.entries.toList()[i].value}\n";
    }
    _sendMessage(sl);
  }

  _checkAndScoreUser(String owner, [int score = 5]) {
    if (leaderboardTable.containsKey(owner)) {
      leaderboardTable[owner] = leaderboardTable[owner]! + 5;
    } else {
      leaderboardTable[owner] = 5;
    }
  }

  String _generateOptions(List<String> p) {
    String op = "";
    for (var i = 0; i < p.length; i++) {
      op += "${demoOptions[i]}. ${p[i]}\n";
    }
    return op;
  }
}

class QuizModel {
  String question, answer;
  List<String> options;

  QuizModel(this.question, this.options, this.answer);

  factory QuizModel.fromMAP(Map<String, String> json) {
    return QuizModel(
        json["question"]!,
        [
          json["A"]!,
          json["B"]!,
          json["C"]!,
          json["D"]!,
        ],
        json["answer"]!);
  }
}
