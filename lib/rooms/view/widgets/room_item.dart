import 'package:chat_app/shared/app_them.dart';
import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppTheme.white,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/movies.png',
              height: MediaQuery.of(context).size.height * .1,
            ),
            const SizedBox(height: 10),
            Text(
              'Room name ',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              '13 member',
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
      ),
    );
  }
}
