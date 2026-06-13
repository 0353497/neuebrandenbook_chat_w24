import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neuebrandenbook_chat/models/message_conversation_item.dart';
import 'package:neuebrandenbook_chat/models/user_conversation_item.dart';
import 'package:neuebrandenbook_chat/pages/mini_profile_modal.dart';
import 'package:neuebrandenbook_chat/services/http_service.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key, required this.roomId});
  final String roomId;
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late final List<UserConversationItem> users;
  late List<MessageConversationItem> messages = [];
  @override
  void initState() {
    super.initState();
    init();
  }

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
              child: messages.isEmpty
                  ? Center(child: Text("no messages"))
                  : ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final MessageConversationItem message = messages[index];
                        final MessageConversationItem? last =
                            messages[(index - 1) % messages.length];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (message.user == null)
                              serverMessage(message.content),
                            if (message.dateTime.difference(
                                  last?.dateTime ?? DateTime.now(),
                                ) >
                                15.minutes)
                              dateMessage(message.dateTime),
                            if (message.user != null &&
                                message.user != "user-1")
                              otherProfileRow(message.user!),
                            if (message.user == "user-1")
                              yourPerson(message.user!),
                            if (message.user != null)
                              messageContainer(
                                message.content,
                                message.dateTime,
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

  Row yourPerson(String userId) {
    final user = users.firstWhere((element) => element.id == userId);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 12,
      children: [
        if (user.isAuthor) Icon(Icons.check, color: Colors.blue),
        Text(user.name),
        InkWell(
          onTap: () => Get.dialog(MiniProfileModal()),
          child: CircleAvatar(
            foregroundImage: NetworkImage(HttpService.asset(user.avatar)),
          ),
        ),
      ],
    );
  }

  CupertinoContextMenu messageContainer(String message, DateTime dateTime) {
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(child: Text("Copy")),
        CupertinoContextMenuAction(child: Text("React with ❤️")),
        CupertinoContextMenuAction(child: Text("Remove reaction")),
      ],
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat("hh:mm a").format(dateTime),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row otherProfileRow(String userId) {
    final user = users.firstWhere((element) => element.id == userId);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 12,
      children: [
        InkWell(
          onTap: () => Get.dialog(MiniProfileModal()),
          child: CircleAvatar(
            foregroundImage: NetworkImage(HttpService.asset(user.avatar)),
          ),
        ),
        if (user.isAuthor) Icon(Icons.check, color: Colors.blue),
        Text(user.name),
      ],
    );
  }

  Row dateMessage(DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat("hh:mm a").format(date),
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Card serverMessage(String content) {
    return Card(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(content),
      ),
    );
  }

  void init() async {
    final res = await HttpService.getConversation(widget.roomId);
    users = res.$1;
    messages = res.$2;
    setState(() {});
  }
}
