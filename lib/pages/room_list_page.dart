import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neuebrandenbook_chat/pages/room_discover_modal.dart';

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
          child: ListView.builder(
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                width: Get.width,
                child: PageView(
                  controller: PageController(initialPage: 1),
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("Leave")),
                    ListTile(
                      leading: Badge.count(
                        backgroundColor: Colors.purple,
                        count: 1,
                        child: CircleAvatar(),
                      ),
                      title: Text("Fantasy $index"),
                      subtitle: Text("Subtitle , $index"),
                      trailing: Text(
                        DateFormat("dd/MM/yyyy").format(DateTime.now()),
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Pin")),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
