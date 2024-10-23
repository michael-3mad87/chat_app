import 'package:chat_app/rooms/data/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomsRemoteDataSources {
  static CollectionReference<RoomModel> getRoomsCollection() =>
      FirebaseFirestore.instance.collection('rooms').withConverter(
            fromFirestore: (snapshot, _) =>
                RoomModel.fromJson(snapshot.data()!),
            toFirestore: (roomModel, _) => roomModel.toJson(),
          );

  Future<void> createRoom(RoomModel room) async {
    final roomsCollection = getRoomsCollection();
    final doc = roomsCollection.doc();
    room.id = doc.id;
    return doc.set(room);
  }

  Future<List<RoomModel>> getRooms() async {
    final roomsCollection = getRoomsCollection();
    final querySnapShot = await roomsCollection.get();
    return querySnapShot.docs.map((docSnapShot) => docSnapShot.data()).toList();
  }
}
