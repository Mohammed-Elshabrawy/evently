import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_setting_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
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
    CollectionReference<Event> eventsCollection =
        getEventsCollection(); //collection
    DocumentReference<Event> eventDoc = eventsCollection.doc(); //doc
    event.id = eventDoc.id;
    return eventDoc.set(event);
  }

  static void updateEventIsFavorite(
    Event event,
    BuildContext context,
    AppSettingProvider appSettingsProvider,
  ) {
    CollectionReference<Event> eventsCollection = getEventsCollection();
    DocumentReference<Event> eventDoc = eventsCollection.doc(event.id);
    eventDoc
        .update({'isFavorite': !event.isFavorite})
        .timeout(
          Duration(seconds: 0),
          onTimeout: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: appSettingsProvider.isLight
                    ? AppColors.mainColor
                    : AppColors.darkMainColor,
                content: Text("event_added_successfully".tr()),
              ),
            );
          },
        );
  }
}
