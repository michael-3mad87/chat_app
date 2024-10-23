part of 'room_cubit.dart';


sealed class RoomState {}

final class RoomInitial extends RoomState {}

final class CreateRoomLoading extends RoomState {}

final class CreateRoomSuccess extends RoomState {}

final class CreateRoomError extends RoomState {
    final String message;
  CreateRoomError(this.message);
}

final class GetRoomLoading extends RoomState {}

final class GetRoomSuccess extends RoomState {}

final class GetRoomError extends RoomState {
  final String message;
  GetRoomError(this.message);
}
