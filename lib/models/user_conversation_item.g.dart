// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_conversation_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConversationItem _$UserConversationItemFromJson(
  Map<String, dynamic> json,
) => UserConversationItem(
  id: json['id'] as String,
  avatar: json['avatar'] as String,
  name: json['name'] as String,
  isAuthor: json['isAuthor'] as bool,
  publishedBooks: json['publishedBooks'] as List<dynamic>,
  sharedRooms: (json['sharedRooms'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$UserConversationItemToJson(
  UserConversationItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'avatar': instance.avatar,
  'name': instance.name,
  'isAuthor': instance.isAuthor,
  'publishedBooks': instance.publishedBooks,
  'sharedRooms': instance.sharedRooms,
};
