// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_conversation_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageConversationItem _$MessageConversationItemFromJson(
  Map<String, dynamic> json,
) => MessageConversationItem(
  id: json['id'] as String,
  user: json['user'] as String?,
  timestamp: json['timestamp'] as String,
  content: json['content'] as String,
  isLiked: json['isLiked'] as bool,
);

Map<String, dynamic> _$MessageConversationItemToJson(
  MessageConversationItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'timestamp': instance.timestamp,
  'content': instance.content,
  'isLiked': instance.isLiked,
};
