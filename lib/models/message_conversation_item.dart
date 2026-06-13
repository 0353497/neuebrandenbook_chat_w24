import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'message_conversation_item.g.dart';

@JsonSerializable()
class MessageConversationItem {
  final String id;
  @JsonKey(readValue: _readUserId)
  final String? user;
  final String timestamp;
  final String content;
  final bool isLiked;

  DateTime get dateTime => DateTime.parse(timestamp);

  @override
  String toString() {
    return jsonEncode(_$MessageConversationItemToJson(this));
  }

  static Object? _readUserId(Map map, String key) =>
      map['user'] ?? map['userId'];

  MessageConversationItem({
    required this.id,
    required this.user,
    required this.timestamp,
    required this.content,
    required this.isLiked,
  });
  factory MessageConversationItem.fromJson(dynamic json) =>
      _$MessageConversationItemFromJson(json);
}
