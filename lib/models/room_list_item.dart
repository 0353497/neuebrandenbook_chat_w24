import 'package:json_annotation/json_annotation.dart';
part 'room_list_item.g.dart';

@JsonSerializable()
class RoomListItem {
  final String id;
  final String title;
  final String description;
  final String avatar;
  final int memberCount;

  RoomListItem({
    required this.id,
    required this.title,
    required this.description,
    required this.avatar,
    required this.memberCount,
  });
  factory RoomListItem.fromJson(dynamic json) => _$RoomListItemFromJson(json);
}
