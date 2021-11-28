// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({
    Key? key,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeToDate = DateTime.fromMillisecondsSinceEpoch(
        snapshot.docs[index]['timestame'].seconds * 1000);
    var dateFormat = DateFormat("EEEE,MM d, y").format(timeToDate);

    var docId = snapshot.docs[index].id;

    var snapshotData = snapshot.docs[index];
    TextEditingController nameInputController =
        TextEditingController(text: snapshotData['name']);
    TextEditingController titleInputController =
        TextEditingController(text: snapshotData['title']);
    TextEditingController descriptionInputController =
        TextEditingController(text: snapshotData['description']);
    return Column(
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          height: 190.0,
          child: Card(
            elevation: 9,
            child: Column(
              children: [
                ListTile(
                  // return Text(snapshot.data!.docs[index]['title'].toString());
                  // title: Text(snapshot.data!.docs[index]['title']),
                  title: Text(snapshot.docs[index]['title']),
                  subtitle: Text(snapshot.docs[index]['description']),
                  leading: CircleAvatar(
                    child: Text(snapshot.docs[index]['title'].toString()[0]),
                    radius: 34.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Name By :${snapshotData['name']}"),
                      Text(dateFormat == " " ? "" : dateFormat),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.edit,
                        size: 15,
                      ),
                      onPressed: () async {
                        debugPrint(docId);
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  children: [
                                    const Text("Please Fill out Form"),
                                    const Divider(
                                      height: 20.0,
                                    ),
                                    TextField(
                                      autocorrect: true,
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                          label: Text("Your Name")),
                                      controller: nameInputController,
                                    ),
                                    const Divider(
                                      height: 20.0,
                                    ),
                                    TextField(
                                      autocorrect: true,
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                          label: Text("Title*")),
                                      controller: titleInputController,
                                    ),
                                    Expanded(
                                        child: TextField(
                                      autocorrect: true,
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                          label: Text("Description*")),
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
                                        if (nameInputController
                                                .text.isNotEmpty &&
                                            titleInputController
                                                .text.isNotEmpty &&
                                            descriptionInputController
                                                .text.isNotEmpty) {
//update Data

                                          FirebaseFirestore.instance
                                              .collection("board")
                                              .doc(docId)
                                              .update({
                                            "name": nameInputController.text,
                                            "title": titleInputController.text,
                                            "description":
                                                descriptionInputController.text,
                                            "timestame": DateTime.now()
                                          }).then((response) {
                                            nameInputController.clear();
                                            titleInputController.clear();
                                            descriptionInputController.clear();

                                            Navigator.pop(context);
                                          }).catchError((onError) {
                                            debugPrint(onError);
                                          });
//end update data

                                          // FirebaseFirestore.instance
                                          //     .collection("board")
                                          //     .add({
                                          //   "name": nameInputController.text,
                                          //   "title": titleInputController.text,
                                          //   "description":
                                          //       descriptionInputController.text,
                                          //   "timestame": DateTime.now()
                                          // }).then((respone) {
                                          //   debugPrint(respone.id);
                                          //   nameInputController.clear();
                                          //   titleInputController.clear();
                                          //   descriptionInputController.clear();

                                          //   Navigator.pop(context);
                                          // }).catchError((onError) {
                                          //   debugPrint(onError);
                                          // });
                                        }
                                      },
                                      child: const Text("Update"))
                                ],
                              );
                            });
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.trashAlt,
                        size: 15,
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("board")
                            .doc(docId)
                            .delete();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
