import 'package:json_annotation/json_annotation.dart';

part 'room_join_item.g.dart';

@JsonSerializable()
class RoomJoinItem {
  final String id;
  final String avatar;
  final String title;
  final dynamic lastMsg;
  final int unreadCount;
  final bool pinned;

  RoomJoinItem({
    required this.id,
    required this.avatar,
    required this.title,
    required this.lastMsg,
    required this.unreadCount,
    required this.pinned,
  });

  DateTime get lastMessageDate => DateTime.parse(lastMsg["timestamp"]);
  factory RoomJoinItem.fromJson(dynamic json) => _$RoomJoinItemFromJson(json);
}
