import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neuebrandenbook_chat/models/room_join_item.dart';
import 'package:neuebrandenbook_chat/pages/conversation_page.dart';
import 'package:neuebrandenbook_chat/pages/room_discover_modal.dart';
import 'package:neuebrandenbook_chat/services/http_service.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NeuBrandenBook",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "Book Club Chats",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.purple),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            tooltip: "Discover Rooms",
            onPressed: () => Get.dialog(RoomDiscoverModal()),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: HttpService.getJoinedRooms(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: asyncSnapshot.data!.length,
                itemBuilder: (context, index) {
                  final List<RoomJoinItem> items = asyncSnapshot.data!;
                  final RoomJoinItem item = items[index];
                  return SizedBox(
                    height: 100,
                    width: Get.width,
                    child: PageView(
                      controller: PageController(initialPage: 1),
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.dialog(
                              Dialog(
                                child: Column(
                                  children: [
                                    Text("Are you sure"),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: Get.back,
                                          child: Text("No"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Get.back();
                                            await HttpService.leave(item.id);
                                            setState(() {});
                                          },
                                          child: Text("Yes"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text("Leave"),
                        ),
                        ListTile(
                          onTap: () => Get.to(
                            () => ConversationPage(roomJoinItem: item),
                          ),
                          leading: Badge.count(
                            isLabelVisible: item.unreadCount >= 0,
                            backgroundColor: Colors.purple,
                            count: item.unreadCount,
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(
                                HttpService.asset(item.avatar),
                              ),
                            ),
                          ),
                          title: Text(item.title),
                          subtitle: Text(
                            item.lastMsg["text"],
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            DateFormat(
                              "dd/MM/yyyy",
                            ).format(item.lastMessageDate),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await HttpService.pin(item.id);
                            setState(() {});
                          },
                          child: Text("Pin"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
