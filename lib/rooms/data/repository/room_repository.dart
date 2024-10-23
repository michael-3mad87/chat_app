import 'package:chat_app/rooms/data/data_sources/rooms_remote_data_sources.dart';

import 'package:chat_app/rooms/data/models/room_model.dart';

class RoomRepository {
  RoomsRemoteDataSources remoteDataSources;
  RoomRepository(this.remoteDataSources);

  Future<void> createRoom(RoomModel room) async {
    return remoteDataSources.createRoom(room);
  }

  Future<List<RoomModel>> getRooms() async {
    return remoteDataSources.getRooms();
  }
}
