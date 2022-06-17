import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Firestore a yeni veri ekleme ve güncelleme hizmeti MEET
  Future<void> setMeetData(
    Map<String, dynamic> meetAsMap,
    String mail,
  ) async {
    await _firestore
        .collection('users')
        .doc(mail)
        .collection('meet')
        .doc()
        .set(meetAsMap);
  }
}
