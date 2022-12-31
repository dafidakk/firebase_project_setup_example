import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project_setup_example/pages/event_page.dart';
import 'package:firebase_project_setup_example/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(SplashPage(
        key: UniqueKey(),
        onInitializationComplete: (() => runApp(
              ProviderScope(
                child: MyApp(),
              ),
            )),
      )));
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
        debugShowCheckedModeBanner: false,
        title: 'Events',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: EventScreen());
  }
}
