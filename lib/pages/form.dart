import 'package:crud_operation/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Formpage extends StatefulWidget {
  const Formpage({super.key});

  @override
  State<Formpage> createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController contact = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORM'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Name'),
              ),
              const Text(
                'Age',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextField(
                controller: age,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter Age'),
              ),
              const Text(
                'Contact Number',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextField(
                controller: contact,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Contact Number'),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        String id = randomAlphaNumeric(10);
                        Map<String, dynamic> detailsInfo = {
                          'Name': name.text,
                          'Age': age.text,
                          'Contact': contact.text,
                        };
                        await Database()
                            .sendDetails(detailsInfo, id)
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Data Added to Database",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                      child: const Text('Upload')))
            ],
          ),
        ),
      ),
    );
  }
}
