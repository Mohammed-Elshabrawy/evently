import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/providers/app_setting_provider.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/snack_bar_utils.dart';
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
    CollectionReference<Event> eventsCollection = getEventsCollection();
    DocumentReference<Event> eventDoc = eventsCollection.doc();
    event.id = eventDoc.id;
    return eventDoc.set(event);
  }

  static void updateEventIsFavorite(
    Event event,
    BuildContext context,
    AppSettingProvider appSettingsProvider,
  ) {
    getEventsCollection()
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite})
        .timeout(
          Duration(microseconds: 500),
          onTimeout: () {
            SnackBarUtils.showSnackBar(
              context: context,
              appSettingsProvider: appSettingsProvider,
              message: 'event_Updated_successfully',
              isError: false,
            );
          },
        );
  }

  static Future<void> deleteEvent(
    String eventId,
    BuildContext context,
    AppSettingProvider appSettingsProvider,
  ) async {
    await getEventsCollection()
        .doc(eventId)
        .delete()
        .timeout(
          Duration(microseconds: 500),
          onTimeout: () {
            Navigator.pop(context);
            Navigator.pop(context);
            SnackBarUtils.showSnackBar(
              context: context,
              appSettingsProvider: appSettingsProvider,
              message: 'event_deleted_successfully',
              isError: true,
            );
          },
        );
  }

  static void updateEvent({
    required Event event,
    required String eventId,
    required BuildContext context,
    required AppSettingProvider appSettingsProvider,
  }) {
    getEventsCollection()
        .doc(eventId)
        .update({
          'title': event.title,
          'description': event.description,
          'date': event.date.millisecondsSinceEpoch,
          'time': event.time,
          'isFavorite': event.isFavorite,
          'name': event.name,
          'image': event.image,
        })
        .timeout(
          Duration(seconds: 1),
          onTimeout: () {
            SnackBarUtils.showSnackBar(
              context: context,
              appSettingsProvider: appSettingsProvider,
              message: 'event_Updated_successfully',
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.homeLayoutRoute,
              (predicate) => false,
            );
          },
        )
        .catchError((error) {
          SnackBarUtils.showSnackBar(
            context: context,
            appSettingsProvider: appSettingsProvider,
            message: 'Something went wrong',
            isError: true,
          );
        });
  }
}
