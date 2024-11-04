import 'package:bloc/bloc.dart';
import 'package:chat_app/Auth/data/models/user_model.dart';
import 'package:chat_app/chat/data/model/message_model.dart';
import 'package:chat_app/chat/data/repository/chat_repository.dart';
import 'package:chat_app/shared/services_locator.dart';
import 'package:flutter/material.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  late final ChatRepository repository;
  final contentController = TextEditingController();
  late final UserModel currentUser;
  late final String roomId;
  ChatCubit() : super(ChatInitial()) {
    repository = ChatRepository(ServicesLocator.chatDataSources);
  }
  Future<void> sendMessage() async {
    if (contentController.text.isEmpty) return;
    emit(SendMessageLoading());
    try {
      final message = MessageModel(
        content: contentController.text,
        dateTime: DateTime.now(),
        senderId: currentUser.id,
        senderName: currentUser.name,
        roomId: roomId,
      );
      contentController.clear();
      await repository.insertMessageToRoom(message);
      emit(SendMessageSuccess());
    } catch (e) {
      emit(SendMessageError());
    }
  }

  Future<void> getMessageStream() async {
    emit(GetMessageLoading());
    try {
      final streamMessages = repository.getRoomMessages(roomId);
      emit(GetMessageSuccess(streamMessages));
    } catch (e) {
      emit(GetMessageError());
    }
  }

  bool isMyMessage(String messageId) => messageId == currentUser.id;
}
