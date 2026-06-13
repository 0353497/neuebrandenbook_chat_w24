import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MiniProfileModal extends StatefulWidget {
  const MiniProfileModal({super.key});
  @override
  State<MiniProfileModal> createState() => _MiniProfileModalState();
}

class _MiniProfileModalState extends State<MiniProfileModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: Get.width,
        height: Get.height * .7,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              CircleAvatar(radius: 50),
              Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Joachim Schiller",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.check_circle, color: Colors.blue),
                ],
              ),
              Chip(label: Text("Author")),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
              for (int i = 0; i < 3; i++)
                Card(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text("Schats der Welten"),
                  ),
                ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "1 Shared room",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Wrap(
                runAlignment: WrapAlignment.start,
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.start,
                children: [Chip(label: Text("Fantasy & adventure Club"))],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
