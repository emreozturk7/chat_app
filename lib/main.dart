import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_app/model/my_user.dart';
import 'package:flutter_chat_app/services/auth.dart';
import 'package:flutter_chat_app/view/message_page.dart';
import 'package:flutter_chat_app/view/wrapper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        routes: {
          'message_page': (context) => const MessagePage(),
        },
        home: const Wrapper(),
      ),
    );
  }
}
