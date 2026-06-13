import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:neuebrandenbook_chat/models/user_conversation_item.dart';
import 'package:neuebrandenbook_chat/services/http_service.dart';

class MiniProfileModal extends StatelessWidget {
  const MiniProfileModal(this.user, {super.key});
  final UserConversationItem user;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: Get.width,
        height: Get.height * .7,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => Get.back,
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 50,
                  foregroundImage: NetworkImage(HttpService.asset(user.avatar)),
                ),
                if (user.isAuthor)
                  Row(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (user.isAuthor)
                        Icon(Icons.check_circle, color: Colors.blue),
                    ],
                  ),
                if (user.isAuthor) Chip(label: Text("Author")),
                if (user.isAuthor)
                  Row(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/Icons/book-open.png",
                        color: Colors.grey,
                        width: 24,
                      ),
                      Text(
                        "Published Books",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                for (int i = 0; i < user.publishedBooks.length; i++)
                  Card(
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(user.publishedBooks[i]),
                    ),
                  ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${user.sharedRooms.length} Shared room",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  runAlignment: WrapAlignment.start,
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.start,
                  children: [
                    for (int i = 0; i < user.sharedRooms.length; i++)
                      Chip(label: Text(user.sharedRooms[i])),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
