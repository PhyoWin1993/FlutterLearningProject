// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:bincard/bloard_firestore/ui/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart';

class BoardApp extends StatefulWidget {
  const BoardApp({Key? key}) : super(key: key);

  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  late TextEditingController nameInputController;
  late TextEditingController titleInputController;
  late TextEditingController descriptionInputController;

  @override
  void initState() {
    super.initState();
    nameInputController = TextEditingController();
    titleInputController = TextEditingController();
    descriptionInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var reference = FirebaseFirestore.instance.collection("board").snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Community Board App"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: const Icon(FontAwesomeIcons.pen),
      ),
      body: StreamBuilder(
        stream: reference,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              //  itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, int index) {
                // return Text(snapshot.data!.docs[index]['title'].toString());

                return CustomCard(snapshot: snapshot.data, index: index);
              });
        },
      ),
    );
  }

  _showDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(10.0),
            content: Column(
              children: [
                const Text("Please Fill out Form"),
                const Divider(
                  height: 20.0,
                ),
                TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: const InputDecoration(label: Text("Your Name")),
                  controller: nameInputController,
                ),
                const Divider(
                  height: 20.0,
                ),
                TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: const InputDecoration(label: Text("Title*")),
                  controller: titleInputController,
                ),
                Expanded(
                    child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration:
                      const InputDecoration(label: Text("Description*")),
                  controller: descriptionInputController,
                )),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    nameInputController.clear();
                    titleInputController.clear();
                    descriptionInputController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    if (nameInputController.text.isNotEmpty &&
                        titleInputController.text.isNotEmpty &&
                        descriptionInputController.text.isNotEmpty) {
                      FirebaseFirestore.instance.collection("board").add({
                        "name": nameInputController.text,
                        "title": titleInputController.text,
                        "description": descriptionInputController.text,
                        "timestame": DateTime.now()
                      }).then((respone) {
                        debugPrint(respone.id);
                        nameInputController.clear();
                        titleInputController.clear();
                        descriptionInputController.clear();

                        Navigator.pop(context);
                      }).catchError((onError) {
                        debugPrint(onError);
                      });
                    }
                  },
                  child: const Text("Save"))
            ],
          );
        });
  }
}
