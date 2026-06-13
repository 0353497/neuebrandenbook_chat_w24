import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neuebrandenbook_chat/models/message_conversation_item.dart';
import 'package:neuebrandenbook_chat/models/room_join_item.dart';
import 'package:neuebrandenbook_chat/models/user_conversation_item.dart';
import 'package:neuebrandenbook_chat/pages/mini_profile_modal.dart';
import 'package:neuebrandenbook_chat/services/http_service.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key, required this.roomJoinItem});
  final RoomJoinItem roomJoinItem;
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late List<UserConversationItem> users = [];
  late List<MessageConversationItem> messages = [];
  late final ScrollController scrollController;
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    refresh();
    HttpService.markRoomAsRead(widget.roomJoinItem.id);
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bool =
        messages.isNotEmpty &&
        scrollController.hasClients &&
        scrollController.position.maxScrollExtent * .7 >
            scrollController.position.pixels;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: bool
          ? FloatingActionButton(
              child: Icon(Icons.arrow_downward),
              onPressed: () {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: 200.milliseconds,
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
      appBar: AppBar(
        leading: IconButton(onPressed: Get.back, icon: Icon(Icons.arrow_back)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(
                HttpService.asset(widget.roomJoinItem.avatar),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Get.width * .6,
                  child: Text(
                    widget.roomJoinItem.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 3,
                  ),
                ),
                Text(
                  "${users.length} members",
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
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final MessageConversationItem message = messages[index];
                        final MessageConversationItem? last = index > 0
                            ? messages[index - 1]
                            : null;
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

                            if (message.user != null) messageContainer(message),
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
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: textEditingController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.emoji_emotions),
                        hintText: "Type a message...",
                      ),
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        textEditingController.value.text.isEmpty
                            ? Colors.purple.withAlpha(100)
                            : Colors.purple,
                      ),
                    ),
                    onPressed: textEditingController.value.text.isEmpty
                        ? null
                        : () async {
                            await HttpService.sendReaction(
                              widget.roomJoinItem.id,
                              textEditingController.value.text,
                            );
                            refresh();
                            setState(() {});
                          },
                    icon: Image.asset(
                      "assets/images/Icons/send.png",
                      width: 24,
                      color: Colors.white,
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
          onTap: () => Get.dialog(MiniProfileModal(user)),
          child: CircleAvatar(
            foregroundImage: NetworkImage(HttpService.asset(user.avatar)),
          ),
        ),
      ],
    );
  }

  CupertinoContextMenu messageContainer(MessageConversationItem message) {
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          child: Text("Copy"),
          onPressed: () async {
            final data = ClipboardData(text: message.content);
            await Clipboard.setData(data);
            Get.snackbar("copied", message.content);
            Get.back();
          },
        ),
        CupertinoContextMenuAction(
          child: Text("React with ❤️"),
          onPressed: () async {
            await HttpService.setReaction(message.id, true);
            refresh();
            Get.back();
          },
        ),
        CupertinoContextMenuAction(
          child: Text("Remove reaction"),
          onPressed: () async {
            await HttpService.setReaction(message.id, false);
            refresh();
            Get.back();
          },
        ),
      ],
      child: Badge(
        alignment: Alignment(.7, .8),
        backgroundColor: Colors.purple,
        isLabelVisible: message.isLiked,
        label: Text("❤️"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            color: message.user == "user-1" ? Colors.purpleAccent : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: message.user != "user-1"
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.content,
                    style: TextStyle(
                      color: message.user == "user-1" ? Colors.white : null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat("HH:mm").format(message.dateTime),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
          onTap: () => Get.dialog(MiniProfileModal(user)),
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

  void refresh() async {
    final res = await HttpService.getConversation(widget.roomJoinItem.id);
    users = res.$1;
    messages = res.$2;
    setState(() {});
  }
}
