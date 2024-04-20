import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future sendDetails(Map<String, dynamic> information, String id) async {
    return await FirebaseFirestore.instance
        .collection('Details')
        .doc(id)
        .set(information);
  }
}
