import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/event_detail.dart';

class FirestoreHelper {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static Future<List<EventDetail>> addNewEvent(EventDetail eventDetail) async {
    await db
        .collection('event_details')
        .doc(eventDetail.id)
        .set(eventDetail.toMap())
        .onError((e, _) => print("Error writing document: $e"));
    return getDetailsList();
  }

  static Future<List<EventDetail>> getDetailsList() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<EventDetail> details = [];

    var data = await db.collection('event_details').get();

    if (data != null) {
      details =
          data.docs.map((document) => EventDetail.fromMap(document)).toList();
    }

    int i = 0;
    for (var detail in details) {
      detail.id = data.docs[i++].id;
    }
    return details;
  }

  static Future<List<EventDetail>> deleteEvent(String documentId) async {
    await db.collection('event_details').doc(documentId).delete();
    return getDetailsList();
  }
}
