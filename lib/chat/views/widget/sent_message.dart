import 'package:chat_app/chat/data/model/message_model.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.message});
  final MessageModel message ;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
            DateFormat.jm().format(message.dateTime),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 15,
              ),
        ),
        const SizedBox(
          width: 18,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Text(
              message.content,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppTheme.white),
            ),
          ),
        ),
      ],
    );
  }
}
