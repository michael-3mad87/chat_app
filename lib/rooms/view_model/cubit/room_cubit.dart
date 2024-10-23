import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:chat_app/rooms/data/models/category_model.dart';
import 'package:chat_app/rooms/data/models/room_model.dart';
import 'package:chat_app/rooms/data/repository/room_repository.dart';
import 'package:chat_app/shared/services_locator.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  late final RoomRepository repository;
  RoomCubit() : super(RoomInitial()) {
    repository = RoomRepository(ServicesLocator.roomDataSources);
 
  }
  List<RoomModel> rooms = [];
  Future<void> createRooms(RoomModel room) async {
    emit(CreateRoomLoading());
    try {
      await repository.createRoom(room);
      emit(CreateRoomSuccess());
    } catch (e) {
      emit(CreateRoomError(e.toString()));
    }
  }

  Future<void> getRooms() async {
    emit(GetRoomLoading());
    try {
      rooms = await repository.getRooms();
      emit(GetRoomSuccess());
    } catch (e) {
      emit(GetRoomError(e.toString()));
    }
  }

  String getCategoryImageName(String categoryId) {
    return CategoryModel.categories
        .firstWhere((category) => category.id == categoryId)
        .imageName;
  }
}
