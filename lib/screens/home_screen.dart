import 'package:chat_app/rooms/view/screens/create_room_screen.dart';
import 'package:chat_app/rooms/view/widgets/room_item.dart';
import 'package:chat_app/rooms/view_model/cubit/room_cubit.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:chat_app/shared/widgets/error_indicator.dart';
import 'package:chat_app/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final roomCubit = RoomCubit();
  @override
  void initState() {
    super.initState();
    roomCubit.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => roomCubit,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            ' Chat App',
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: AppTheme.white,
              size: 30,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 35, right: 35),
            child: BlocBuilder<RoomCubit, RoomState>(
              builder: (context, state) {
                if (state is GetRoomLoading) {
                  return const LoadingIndicator();
                } else if (state is GetRoomSuccess) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (_, index) => RoomItem(
                      room: roomCubit.rooms[index],
                    ),
                    itemCount: roomCubit.rooms.length,
                  );
                } else if (state is GetRoomError) {
                  return ErrorIndicator(message: state.message);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, CreateRoomScreen.routeName).then(
              (_) => roomCubit.getRooms(),
            );
          },
        ),
      ),
    );
  }
}
