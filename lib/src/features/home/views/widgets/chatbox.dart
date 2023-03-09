import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triviago/src/global/services/mypref.dart';
import 'package:triviago/src/global/ui/widgets/others/containers.dart';

import '../../../../global/ui/ui_barrel.dart';
import '../../../../src_barrel.dart';
import '../../models/message.dart';

class ChatBoxWidget extends StatelessWidget {
  final Messages msg;
  final bool lastMsgBySamePerson;
  ChatBoxWidget(this.msg, {this.lastMsgBySamePerson = false, super.key});

  @override
  Widget build(BuildContext context) {
    final c = Ui.width(context) - 48;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment:
          msg.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: c - (c / 3)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (msg.owner != MyPrefs.localUser().username)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.medium(msg.owner, fontSize: 14, color: msg.color),
                    Ui.boxWidth(12),
                    AppText.thin(DateFormat("hh:mm").format(msg.time),
                        color: AppColors.white40, fontSize: 10),
                  ],
                ),
              AppText.thin(msg.desc!, fontSize: 14),
              if (!lastMsgBySamePerson) Ui.boxHeight(8)
            ],
          ),
        ),
      ],
    );
  }
}
