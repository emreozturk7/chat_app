import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _controller = TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return const Text('Some text');
                  },
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: deviceSize.width,
              child: Card(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: deviceSize.width / 50),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        buildShowModalBottomSheet(context, deviceSize);
                      },
                    ),
                    SizedBox(width: deviceSize.width / 35),
                    SizedBox(
                      width: ((deviceSize.width / 5) * 4),
                      height: deviceSize.height / 12,
                      child: TextField(
                        controller: _controller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Deneme',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
