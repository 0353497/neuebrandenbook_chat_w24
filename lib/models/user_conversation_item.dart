import 'package:json_annotation/json_annotation.dart';

part 'user_conversation_item.g.dart';

@JsonSerializable()
class UserConversationItem {
  final String id;
  final String avatar;
  final String name;
  final bool isAuthor;
  final List publishedBooks;
  final List<String> sharedRooms;

  UserConversationItem({
    required this.id,
    required this.avatar,
    required this.name,
    required this.isAuthor,
    required this.publishedBooks,
    required this.sharedRooms,
  });
  factory UserConversationItem.fromJson(dynamic json) =>
      _$UserConversationItemFromJson(json);
}
