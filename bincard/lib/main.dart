import 'package:bincard/bloard_firestore/board_app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// // ignore: prefer_const_constructors
// void main() => runApp(MaterialApp(home: BinCard()));

// ignore: prefer_const_constructors
// void main() => runApp(MaterialApp(home: JsonParsingMap()));

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: BoardApp()));
}
