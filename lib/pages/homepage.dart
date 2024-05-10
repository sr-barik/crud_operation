import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operation/pages/form.dart';
import 'package:crud_operation/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Stream<QuerySnapshot> detailsStream;

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    detailsStream =
        FirebaseFirestore.instance.collection('Details').snapshots();
  }

  Widget getDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: detailsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = docs[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Name: ${ds['Name']}'),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: (
                                        
                                      ) {
                                        name.text=ds['Name'];
                                        age.text=ds['Age'];
                                        contact.text=ds['Contact'];
                                        editDetails(ds['id']);},
                                      child: const Icon(
                                        Icons.edit,
                                        color: Color.fromARGB(255, 34, 67, 255),
                                      )),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: GestureDetector(
                                        onTap: ()async{
                                          await Database().deleteDetails(ds['id']);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                          Text('Age: ${ds['Age']}'),
                          Text('Contact Number: ${ds['Contact']}')
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container(); // Placeholder widget when snapshot has no data
        }
      },
    );
  }
TextEditingController name =TextEditingController();
TextEditingController age =TextEditingController();
TextEditingController contact =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Formpage()));
        },
      ),
      appBar: AppBar(
        title: const Text('CRUD'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: getDetails()),
          ],
        ),
      ),
    );
  }
    Future<void> editDetails(String id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: age,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: contact,
              decoration: const InputDecoration(labelText: 'Contact'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement edit functionality
              Navigator.of(context).pop();
            },
            child: GestureDetector(
              onTap: ()async{
                Map<String,dynamic>updateInfo={
                  "Name": name.text,
                  "Age": age.text,
                  "id": id,
                  "Contact": contact.text
                };
                await Database().updateDetails(id, updateInfo).then((value) {
                  Navigator.pop(context);
                });
              },
              child: const Text('Update')),
          ),
        ],
      ),
    );
  }
}