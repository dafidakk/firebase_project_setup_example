import 'package:firebase_project_setup_example/firestore_helper.dart';
import 'package:firebase_project_setup_example/utils/conts.dart';
import 'package:firebase_project_setup_example/utils/my_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_setup_example/models/event_detail.dart';

import 'package:uuid/uuid.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<EventDetail> details = [];

  @override
  void initState() {
    if (mounted) {
      FirestoreHelper.getDetailsList().then((data) {
        setState(() {
          details = data;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        title: Text("Events"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: details.length,
          itemBuilder: (context, index) {
            EventDetail currentEvent = details[index];
            String description = currentEvent.description;
            String date = currentEvent.date;
            String startTime = currentEvent.startTime;
            String endTime = currentEvent.endTime;
            String subtitle = 'Date: $date - Start: $startTime - End:$endTime';
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Dismissible(
                key: Key(currentEvent.id),
                onDismissed: (DismissDirection direction) {
                  FirestoreHelper.deleteEvent(currentEvent.id).then((value) {
                    setState(() {
                      details = value;
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "${currentEvent.description} dismissed",
                    style: googleFonts(15, Colors.yellow, FontWeight.bold),
                  )));
                },
                background: Container(
                  color: Colors.red.shade700,
                ),
                child: ListTile(
                  title: Text(description),
                  subtitle: Text(subtitle),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade100,
        onPressed: () async {
          final List<String> result = await createAlertDialog(context);

          if (result.isNotEmpty) {
            final EventDetail newEvent = EventDetail(
              Uuid().v1(),
              result[0],
              result[1],
              result[2],
              result[3],
              result[4],
              result[5],
            );

            FirestoreHelper.addNewEvent(newEvent).then(
              (value) {
                setState(
                  () {
                    details = value;
                  },
                );
              },
            );
          }
        },
        child: Icon(Icons.add_circle),
      ),
    );
  }

  Future<List<String>> createAlertDialog(BuildContext context) async {
    List<String> result = [];

    List<TextEditingController> _controllers =
        List.generate(6, (_) => TextEditingController());

    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'New Event',
            style: googleFonts(25, Colors.purple.shade900, FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _controllers[0],
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                TextField(
                  controller: _controllers[1],
                  decoration: InputDecoration(hintText: 'Date'),
                ),
                TextField(
                  controller: _controllers[2],
                  decoration: InputDecoration(hintText: 'Start Time'),
                ),
                TextField(
                  controller: _controllers[3],
                  decoration: InputDecoration(hintText: 'End Time'),
                ),
                TextField(
                  controller: _controllers[4],
                  decoration: InputDecoration(hintText: 'Speaker'),
                ),
                TextField(
                  controller: _controllers[5],
                  decoration: InputDecoration(hintText: 'Is Favorite'),
                ),
              ],
            ),
          ),
          actions: [
            MyElevatedButton(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(result),
            ),
            MyElevatedButton(
              text: 'Add',
              onPressed: () {
                for (var element in _controllers) {
                  result.add(element.text);
                }
                Navigator.of(context).pop(result);
              },
            )
          ],
        );
      },
    );
  }
}
