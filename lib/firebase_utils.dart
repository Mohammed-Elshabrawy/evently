import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/event_model.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, _) => event.toFireStore(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    CollectionReference<Event> eventsCollection = getEventsCollection();   //collection
    DocumentReference<Event> eventDoc = eventsCollection.doc();   //doc
    event.id = eventDoc.id;
    return eventDoc.set(event);
  }
}
