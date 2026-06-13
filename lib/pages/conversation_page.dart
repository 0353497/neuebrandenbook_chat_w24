import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neuebrandenbook_chat/pages/mini_profile_modal.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key, required this.roomId});
  final String roomId;
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: Get.back, icon: Icon(Icons.arrow_back)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            CircleAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "4 members",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 1,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Get.theme.cardColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text("Person $index joined the room"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat("hh:mm a").format(DateTime.now()),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 12,
                        children: [
                          InkWell(
                            onTap: () => Get.dialog(MiniProfileModal()),
                            child: CircleAvatar(),
                          ),
                          Text("person $index"),
                        ],
                      ),
                      CupertinoContextMenu(
                        actions: [
                          CupertinoContextMenuAction(child: Text("Copy")),
                          CupertinoContextMenuAction(
                            child: Text("React with ❤️"),
                          ),
                          CupertinoContextMenuAction(
                            child: Text("Remove reaction"),
                          ),
                        ],
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "this is a large message that a person is saying and i am testing if it will wrap",
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat(
                                        "hh:mm a",
                                      ).format(DateTime.now()),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 12,
                        children: [Text("person $index"), CircleAvatar()],
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 120,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/Icons/paperclip.png",
                      width: 24,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.emoji_emotions),
                        hintText: "Type a message...",
                      ),
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.purple),
                    ),
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/Icons/send.png",
                      color: Colors.white,
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
