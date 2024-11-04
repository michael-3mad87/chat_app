import 'package:chat_app/chat/data/model/message_model.dart';
import 'package:chat_app/rooms/data/data_sources/rooms_remote_data_sources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRemoteDateSources {
static final RoomsRemoteDataSources roomsRemoteDataSources = RoomsRemoteDataSources();
 static CollectionReference<MessageModel> getMessagesCollection(String roomId) =>
      roomsRemoteDataSources
          .getRoomsCollection()
          .doc(roomId)
          .collection('messages')
          .withConverter(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromJson(snapshot.data()!),
            toFirestore: (messageModel, _) => messageModel.toJson(),
          );
  Future<void> insertMessageToRoom(MessageModel message) async {
    final messagesCollection = getMessagesCollection(message.roomId);
    final doc = messagesCollection.doc();
    message.id = doc.id;
    doc.set(message);
  }

   Stream<List<MessageModel>> getRoomMessages(String roomId) {
    final messagesCollection = getMessagesCollection(roomId);
   return messagesCollection.orderBy('dateTime').snapshots().map(
          (querySnapShot) => querySnapShot.docs
              .map(
                (docSnapShot) => docSnapShot.data(),
              )
              .toList(),
        );
  }
}
/* make stream with firebase 
 1- get collection ,
 2- snapshots from collection,this return querySnapShots have all query you need to access just one 
 
  
*/