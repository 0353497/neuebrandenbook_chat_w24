// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_join_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomJoinItem _$RoomJoinItemFromJson(Map<String, dynamic> json) => RoomJoinItem(
  id: json['id'] as String,
  avatar: json['avatar'] as String,
  title: json['title'] as String,
  lastMsg: json['lastMsg'],
  unreadCount: (json['unreadCount'] as num).toInt(),
  pinned: json['pinned'] as bool,
);

Map<String, dynamic> _$RoomJoinItemToJson(RoomJoinItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'title': instance.title,
      'lastMsg': instance.lastMsg,
      'unreadCount': instance.unreadCount,
      'pinned': instance.pinned,
    };
