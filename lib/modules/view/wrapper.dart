import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/my_user.dart';
import 'package:flutter_chat_app/modules/authenticate/authenticate.dart';
import 'package:flutter_chat_app/modules/home/home_view.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return user == null ? const Authenticate() : HomeView();
  }
}
