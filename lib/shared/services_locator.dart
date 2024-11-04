import 'package:chat_app/chat/data/data_source/chat_date_sources.dart';
import 'package:chat_app/rooms/data/data_sources/rooms_remote_data_sources.dart';

class ServicesLocator {
  static final roomDataSources = RoomsRemoteDataSources();
  static final chatDataSources = ChatRemoteDateSources();
}