import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:neuebrandenbook_chat/models/room_join_item.dart';
import 'package:neuebrandenbook_chat/models/room_list_item.dart';

class HttpService {
  static String baseUrl = "http://10.0.2.2:3000";
  static Future<List<RoomListItem>> getRooms() async {
    try {
      final res = await http.get(Uri.parse("$baseUrl/rooms"));
      final List json = jsonDecode(res.body);
      final List<RoomListItem> data = json
          .map((e) => RoomListItem.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<List<RoomJoinItem>> getJoinedRooms() async {
    try {
      final res = await http.get(Uri.parse("$baseUrl/rooms/joined"));
      final List json = jsonDecode(res.body);
      final List<RoomJoinItem> data = json
          .map((e) => RoomJoinItem.fromJson(e))
          .toList();
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static String asset(String asset) => "http://10.0.2.2:3000/assets/$asset";

  static Future<void> pin(String roomId) async {
    try {
      final res = await http.patch(Uri.parse("$baseUrl/rooms/$roomId/pin"));
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> leave(String roomId) async {
    try {
      final res = await http.patch(Uri.parse("$baseUrl/rooms/$roomId/leave"));
    } catch (e) {
      rethrow;
    }
  }
}
