import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactsController extends GetxController {
  late TextEditingController searchCtrl;

  var query = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void searchContacts(String data, String email) async {
    print('SEARCH : $data');

    if (data.length == 0) {
      query.value = [];
      tempSearch.value = [];
    } else {
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);
      print(capitalized);

      if (query.length == 0 && data.length == 1) {
        CollectionReference users = await firestore.collection('users');
        final keyNameResult = await users
            .where('keyname', isEqualTo: data.substring(0, 1).toUpperCase())
            .where('email', isEqualTo: email)
            .get();

        print('TOTAL DATA : ${keyNameResult.docs.length}');
        if (keyNameResult.docs.length > 0) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            query.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
          print('QUERY RESULT : ');
          print(query);
        } else {
          print('NO DATA');
        }
      }
      if (query.length != 0) {
        tempSearch.value = [];
        query.forEach((element) {
          if (element['name'].startsWith(capitalized)) {
            tempSearch.add(element);
          }
        });
      }
    }
    query.refresh();
    tempSearch.refresh();
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
