// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomListItem _$RoomListItemFromJson(Map<String, dynamic> json) => RoomListItem(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  avatar: json['avatar'] as String,
  memberCount: (json['memberCount'] as num).toInt(),
);

Map<String, dynamic> _$RoomListItemToJson(RoomListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'avatar': instance.avatar,
      'memberCount': instance.memberCount,
    };
