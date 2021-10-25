import 'package:flutter/material.dart';
import 'package:flutter_chat_app/modules/home/home_controller.dart';
import 'package:flutter_chat_app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final List<Widget> myChats = List.generate(
    20,
    (index) => ListTile(
      onTap: () => Get.toNamed(Routes.MESSAGE_VIEW),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black26,
        child: Image.asset(
          "assets/images/noimage.png",
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        'Emre${index + 1}',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        'Alinan son mesaj ${index + 1}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Chip(
        label: Text("3"),
      ),
    ),
  ).reversed.toList();

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.put(HomeController());
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black38,
                  ),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.PROFILE_VIEW);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: Text(
                      "Chats",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: myChats.length,
              itemBuilder: (context, index) => myChats[index],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.message),
        onPressed: () {
          Get.toNamed(Routes.CONTACTS_VIEW);
        },
      ),
    );
  }
}
