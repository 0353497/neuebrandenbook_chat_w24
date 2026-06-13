import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neuebrandenbook_chat/models/room_list_item.dart';

class HttpService {
  static String baseUrl = "http://10.0.0.2";
  static Future<List<RoomListItem>> getRooms() async {
    final res = await http.get(Uri.parse("$baseUrl/rooms"));
    final List json = jsonDecode(res.body);
    final List<RoomListItem> data = json
        .map((e) => RoomListItem.fromJson(e))
        .toList();
    return data;
  }
}
