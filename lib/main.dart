import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future testData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var data = await db.collection('event_details').get();
    var details = data.docs.toList();
    details.forEach((item) {
      print(item.id);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    testData();
    return MaterialApp(
      title: 'Events',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const FireBasePage(title: 'Firebase Demo Home Page'),
    );
  }
}

class FireBasePage extends StatefulWidget {
  final String title;
  const FireBasePage({super.key, required this.title});
  @override
  State<FireBasePage> createState() => _FireBasePageState();
}

class _FireBasePageState extends State<FireBasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
