import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  final String content;
  final DateTime dateTime;
  final String senderId;
  final String senderName;
  final String roomId;
  MessageModel({
    this.id = '',
    required this.content,
    required this.dateTime,
    required this.senderId,
    required this.senderName,
    required this.roomId
  });
  MessageModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          roomId: json['roomId'],
          content: json['content'],
          senderId: json['senderId'],
          senderName: json['senderName'],
          dateTime: (json['dateTime'] as Timestamp).toDate(),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'dateTime': FieldValue.serverTimestamp(),
        'senderId': senderId,
        'senderName': senderName,
        'roomId':roomId
      };
}
