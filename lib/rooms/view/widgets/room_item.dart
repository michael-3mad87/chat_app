import 'package:chat_app/rooms/data/models/room_model.dart';
import 'package:chat_app/rooms/view_model/cubit/room_cubit.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key, required this.room});
  final RoomModel room;
  @override
  Widget build(BuildContext context) {
    final categoryImageName = BlocProvider.of<RoomCubit>(context)
        .getCategoryImageName(room.categoryId);
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
              'assets/images/$categoryImageName.png',
              height: MediaQuery.of(context).size.height * .1,
            ),
            const SizedBox(height: 10),
            Text(
              room.name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              room.description,
              style: Theme.of(context).textTheme.labelSmall,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
