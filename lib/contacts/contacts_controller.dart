import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsController extends GetxController {
  late TextEditingController searchC;

  var query = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void searchContacts(String data, String email) async {}
}
