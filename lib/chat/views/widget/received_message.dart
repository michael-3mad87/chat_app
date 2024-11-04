import 'package:chat_app/chat/data/model/message_model.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.senderName,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppTheme.grey),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(13),
                decoration: const BoxDecoration(
                  color: AppTheme.lightGrey,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                 message.content,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
             DateFormat.jm().format(message.dateTime),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
