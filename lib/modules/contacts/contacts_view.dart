import 'package:flutter/material.dart';
import 'package:flutter_chat_app/modules/contacts/contacts_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ContactsView extends StatelessWidget {
  ContactsView({Key? key}) : super(key: key);
  final List<Widget> contacts = List.generate(
    20,
    (index) => ListTile(
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
      trailing: GestureDetector(
        onTap: () => Get.toNamed("/message_page"),
        child: const Chip(
          label: Text("Message"),
        ),
      ),
    ),
  ).reversed.toList();
  @override
  Widget build(BuildContext context) {
    final ContactsController _controller = Get.put(ContactsController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Contacts'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextField(
                controller: _controller.searchCtrl,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  hintText: 'Search',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => _controller.tempSearch.isEmpty
            ? Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Lottie.asset("assets/lottie/empty.json"),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: contacts.length,
                itemBuilder: (context, index) => contacts[index],
              ),
      ),
    );
  }
}
