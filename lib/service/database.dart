import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future sendDetails(Map<String, dynamic> information, String id) async {
    return await FirebaseFirestore.instance
        .collection('Details')
        .doc(id)
        .set(information);
  }
  Future <Stream<QuerySnapshot>> getDetails() async{
  return await FirebaseFirestore.instance.collection("Details").snapshots(); 
  }

  Future updateDetails(String id, Map<String, dynamic> updateInfo)async{
    return await FirebaseFirestore.instance.collection("Details").doc(id).update(updateInfo);

  }

  Future deleteDetails(String id)async{
    return await FirebaseFirestore.instance.collection("Details").doc(id).delete();

  }
}
