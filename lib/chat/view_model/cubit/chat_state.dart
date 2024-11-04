part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class SendMessageLoading extends ChatState {}

final class SendMessageSuccess extends ChatState {}

final class SendMessageError extends ChatState {}

final class GetMessageLoading extends ChatState {}

final class GetMessageSuccess extends ChatState {
  final Stream<List<MessageModel>> streamMessages;
  GetMessageSuccess(this.streamMessages);
}

final class GetMessageError extends ChatState {}
