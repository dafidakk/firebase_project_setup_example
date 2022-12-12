import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project_setup_example/models/event_detail.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<EventDetail> details = [];

  @override
  void initState() {
    if (mounted) {
      getDetailsList().then((data) {
        setState(() {
          details = data;
        });
      });
    }
    super.initState();
  }

  Future<List<EventDetail>> getDetailsList() async {
    var data = await db.collection('event_details').get();

    if (data != null) {
      details =
          data.docs.map((document) => EventDetail.fromMap(document)).toList();
    }

    int i = 0;
    details.forEach((detail) {
      detail.id = data.docs[i++].id;
    });
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: details.length,
      itemBuilder: (context, index) {
        EventDetail currentEvent = details[index];
        String description = currentEvent.description;
        String date = currentEvent.date;
        String startTime = currentEvent.startTime;
        String endTime = currentEvent.endTime;
        String subtitle = 'Date: $date - Start: $startTime - End:$endTime';
        return ListTile(
          title: Text(description),
          subtitle: Text(subtitle),
        );
      },
    );
  }
}
