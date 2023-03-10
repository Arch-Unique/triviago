import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:triviago/src/features/home/controllers/message_controller.dart';
import 'package:triviago/src/features/home/models/triviago.dart';
import 'package:triviago/src/features/registration/views/login_screen.dart';
import 'package:triviago/src/global/services/http_service.dart';
import 'package:triviago/src/global/ui/widgets/others/containers.dart';
import 'package:triviago/src/src_barrel.dart';

import '../../../global/ui/ui_barrel.dart';
import '../../../plugin/flutter_social_textfield/flutter_social_textfield.dart';
import 'widgets/chatbox.dart';
// import 'package:places/services/httpservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isLastPage = false;
  bool isPressed = false;
  int curpg = 1;
  Color col = AppColors.primaryColor;

  final controller = Get.find<MessageController>();
  final gameController = Get.find<TriviaGo>();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )..addListener(() {
      setState(() {});
    });

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      gameController.startGame();
      final position = controller.listScrollController.position.maxScrollExtent;
      controller.listScrollController.jumpTo(position);
    });
    super.initState();
  }

  getComments({int cp = 1}) async {
    // p = await HttpService.getAllComments(postId: post.id, pg: cp);
    // allComments = p.t;
    // isLastPage = p.isLastPage;
    // allComments.sort((a, b) => a.dt.compareTo(b.dt));
    // isGettingComment = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: buildTyper(),
      body: SafeArea(
        child: Column(children: [
          Row(
            children: [
              Ui.boxWidth(8),
              MyLogo(),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Ui.showBottomSheet(
                        "Logout",
                        "Are you sure you want to logout ?",
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.close)), yesBtn: () async {
                      await HttpService.logout();
                      Get.offAll(LoginScreen());
                    });
                  },
                  icon: Icon(
                    IconlyBold.logout,
                    color: AppColors.primaryColor,
                  ))
            ],
          ),
          Obx(() {
            return Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    controller: controller.listScrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (ctx, i) {
                      final m = controller.getMsg(i);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: AppText.medium(
                                controller.msgKeys[i].toUpperCase(),
                                fontSize: 12,
                                color: AppColors.grey),
                          ),
                          ...List.generate(
                              m.length, (index) => ChatBoxWidget(m[index]))
                        ],
                      );
                    },
                    itemCount: controller.msgs.length,
                  )),
            );
          }),
          Ui.boxHeight(64)
          // buildTyper(),
        ]),
      ),
    );
  }

  Container buildTyper() {
    final animationValue = 1 - _controller.value;
    final scale = 1 + 0.2 * _controller.value;
    final opacity = animationValue;
    return Container(
      padding: const EdgeInsets.all(8),
      color: col,
      child: SafeArea(
        child: SizedBox(
          width: Ui.width(context),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 6,
                  minLines: 1,
                  controller: controller.textEditingController,
                  scrollPhysics: ClampingScrollPhysics(),
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                      hintText: "How you dey ?",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: AppColors.white.withOpacity(0.7),
                      )),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.white),
                      ),
                      hintStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                          color: AppColors.white.withOpacity(0.5))),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTapDown: (_) async {
                  setState(() {
                    isPressed = true;
                  });
                  controller.addNewMsg();

                  // await getComments();

                  controller.textEditingController.clear();
                  setState(() {
                    isPressed = false;
                  });
                },
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: isPressed
                            ? const CircularProgress(24)
                            : Icon(
                                IconlyLight.send,
                                color: col,
                              )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
