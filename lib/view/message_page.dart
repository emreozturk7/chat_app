import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/view/home_page.dart';
import 'package:image_picker/image_picker.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  File? file;
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 5),
              const Icon(Icons.arrow_back),
              const SizedBox(width: 5),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Image.asset("assets/images/noimage.png"),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Lorem Ipsum',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'statusnya lorem',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                ItemChat(
                  isSender: false,
                ),
                ItemChat(
                  isSender: true,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height / 100,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    buildShowModalBottomSheet(context, deviceSize);
                  },
                ),
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.emoji_emotions),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Material(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green[900],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> buildShowModalBottomSheet(
      BuildContext context, Size deviceSize) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: deviceSize.height / 2,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildElevatedButton(
                  const Text('Select Photo'),
                  ImageSource.gallery,
                ),
                buildElevatedButton(
                  const Text('Take a Photo'),
                  ImageSource.camera,
                ),
                buildElevatedButton(
                  const Text('Select Video'),
                  ImageSource.gallery,
                ),
                buildElevatedButton(
                  const Text('Take a Video'),
                  ImageSource.camera,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ElevatedButton buildElevatedButton(Text text, ImageSource source) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: text,
      onPressed: () {
        selectPhoto(source);
      },
    );
  }

  Future<XFile?> selectVideo(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? pickedVideo = await _picker.pickVideo(
      source: source,
      maxDuration: const Duration(seconds: 90),
    );

    setState(() {
      if (pickedVideo != null) {
        file = File(pickedVideo.path);
      } else {
        print('No Video Selected');
      }
    });
    if (pickedVideo != null) {
      uploadStorage(file!);
    }
  }

  Future<XFile?> selectPhoto(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? pickedPhoto = await _picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    setState(() {
      if (pickedPhoto != null) {
        file = File(pickedPhoto.path);
      } else {
        print('No Photo Selected');
      }
    });
    if (pickedPhoto != null) {
      uploadStorage(file!);
    }
  }

  Future<String?> uploadStorage(File file) async {
    String path = '${DateTime.now().millisecondsSinceEpoch}';

    TaskSnapshot uploadTask = await FirebaseStorage.instance
        .ref()
        .child('files')
        .child(path)
        .putFile(file);
    print(uploadTask);
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
  }) : super(key: key);
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSender ? Colors.blue[900] : Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: isSender
                    ? const Radius.circular(15)
                    : const Radius.circular(0),
                bottomRight: isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Selam ben emre',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Text('18:22 PM'),
        ],
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
