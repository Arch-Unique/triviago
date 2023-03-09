import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triviago/src/global/ui/widgets/others/containers.dart';

import '../../../../global/ui/ui_barrel.dart';
import '../../../../src_barrel.dart';
import '../../models/message.dart';

class ChatBoxWidget extends StatelessWidget {
  final Messages msg;
  ChatBoxWidget(this.msg, {super.key});

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
              AppText.medium(msg.owner,
                  fontSize: 17, color: AppColors.primaryColor),
              AppText.thin(msg.desc!, fontSize: 14),
              Ui.align(
                align: Alignment.centerRight,
                child: AppText.thin(DateFormat("d/M/y").format(msg.time),
                    fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
