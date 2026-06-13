import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class RoomDiscoverModal extends StatefulWidget {
  const RoomDiscoverModal({super.key});

  @override
  State<RoomDiscoverModal> createState() => _RoomDiscoverModalState();
}

class _RoomDiscoverModalState extends State<RoomDiscoverModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: Get.width,
        height: Get.height * .8,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text(
                    "Discover Rooms",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              Text(
                "“Join book clubs and chat with other readers and authors",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SearchBar(
                elevation: WidgetStatePropertyAll(1),
                leading: Icon(Icons.search, color: Colors.grey),
                hintText: "Search for rooms...",
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.maxFinite,
                      height: 160,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [CircleAvatar()],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Title",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "$index members",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        "$index descriptions",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Colors.purple,
                                      ),
                                      foregroundColor: WidgetStatePropertyAll(
                                        Colors.black,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text("Join"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
