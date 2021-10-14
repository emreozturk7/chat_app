import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:get/get.dart';

class MessageHomePage extends StatelessWidget {
  MessageHomePage({Key? key}) : super(key: key);
  final List<Widget> myChats = List.generate(
    20,
    (index) => ListTile(
      onTap: () => Get.toNamed("/message_page"),
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
    AuthService _auth = AuthService();
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
                  const Text(
                    "Chats",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      size: 35,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _auth.signOut();
                    },
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
        child: const Icon(Icons.message),
        onPressed: () {
          Navigator.pushNamed(context, '/message_contacts');
        },
      ),
    );
  }
}
