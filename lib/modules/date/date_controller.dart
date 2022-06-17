import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/meet_model.dart';
import 'package:flutter_chat_app/service/database.dart';
import 'package:get/get.dart';

class DateController extends GetxController {
  final Database _database = Database();
  String collectionPath = 'database';

  late TextEditingController searchCtrl;

  var query = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void searchContacts(String data, String email) async {
    print('SEARCH : $data');

    if (data.isEmpty) {
      query.value = [];
      tempSearch.value = [];
    } else {
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);
      print(capitalized);

      if (query.isEmpty && data.length == 1) {
        CollectionReference users = await firestore.collection('users');
        final keyNameResult = await users
            .where('keyName', isEqualTo: data.substring(0, 1).toUpperCase())
            .where('email', isNotEqualTo: email)
            .get();

        print('TOTAL DATA : ${keyNameResult.docs.length}');
        if (keyNameResult.docs.isNotEmpty) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            query.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          print('QUERY RESULT : ');
          print(query);
        } else {
          print('NO DATA');
        }
      }
      if (query.isNotEmpty) {
        tempSearch.value = [];
        for (var element in query) {
          if (element['name'].startsWith(capitalized)) {
            tempSearch.add(element);
          }
        }
      }
    }
    query.refresh();
    tempSearch.refresh();
  }

  Future<void> addNewMeet({
    required String senderEmail,
    required String receiverEmail,
    required String date,
    required String hour,
    required String senderName,
    required String receiverName,
    required String status,
  }) async {
    Meet newMeet = Meet(
      senderEmail: senderEmail,
      receiverEmail: receiverEmail,
      date: date,
      hour: hour,
      senderName: senderName,
      receiverName: receiverName,
      status: status,
    );

    Future<void> addMeet() async {
      CollectionReference database =
          FirebaseFirestore.instance.collection('users');
      final docCompany = database.doc(senderEmail).collection('meet');
      return docCompany
          .add({
            'senderEmail': senderEmail,
            'receiverEmail': receiverEmail,
            'date': date,
            'hour': hour,
            'senderName': senderName,
            'receiverName': receiverName,
            'status': status,
          })
          .then((value) => print("Meet Added"))
          .catchError((error) => print("Failed to add meet: $error"));
    }

    await _database.setMeetData(newMeet.toMap(), senderEmail);
    await _database.setMeetData(newMeet.toMap(), receiverEmail);
  }

  @override
  void onInit() {
    searchCtrl = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }
}
