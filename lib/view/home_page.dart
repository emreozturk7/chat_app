import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
            },
            icon: const Icon(Icons.close),
          ),
        ],
        title: const Text('Home Page'),
      ),
    );
  }
}
