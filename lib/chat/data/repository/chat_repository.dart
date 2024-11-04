import 'package:chat_app/chat/data/data_source/chat_date_sources.dart';
import 'package:chat_app/chat/data/model/message_model.dart';

class ChatRepository {
  ChatRemoteDateSources chatRemoteDateSources;
  ChatRepository(this.chatRemoteDateSources);
  Future<void> insertMessageToRoom(MessageModel message)async  {
    return chatRemoteDateSources.insertMessageToRoom(message);
  }

  Stream<List<MessageModel>> getRoomMessages(String roomId)  {
    return chatRemoteDateSources.getRoomMessages(roomId);
  }
}
