import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/providers/app_setting_provider.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'models/event_model.dart';
import 'models/user_model.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventsCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, _) => event.toFireStore(),
        );
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, _) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (myUser, _) => myUser.toFireStore(),
        );
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    CollectionReference<Event> eventsCollection = getEventsCollection(uId);
    DocumentReference<Event> eventDoc = eventsCollection.doc();
    event.id = eventDoc.id;
    return eventDoc.set(event);
  }

  static void updateEventIsFavorite(
    Event event,
    BuildContext context,
    AppSettingProvider appSettingsProvider,
    String uId,
  ) {
    getEventsCollection(
      uId,
    ).doc(event.id).update({'isFavorite': !event.isFavorite}).then((_) {
      SnackBarUtils.showSnackBar(
        context: context,
        appSettingsProvider: appSettingsProvider,
        message: 'event_Updated_successfully',
        isError: false,
      );
    });
  }

  static Future<void> deleteEvent(
    String eventId,
    BuildContext context,
    AppSettingProvider appSettingsProvider,
    String uId,
  ) async {
    await getEventsCollection(uId).doc(eventId).delete().then((_) {
      Navigator.pop(context);
      Navigator.pop(context);
      SnackBarUtils.showSnackBar(
        context: context,
        appSettingsProvider: appSettingsProvider,
        message: 'event_deleted_successfully',
        isError: true,
      );
    });
  }

  static void updateEvent({
    required Event event,
    required String eventId,
    required BuildContext context,
    required AppSettingProvider appSettingsProvider,
    required String uId,
  }) {
    getEventsCollection(uId)
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
        .then((_) {
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
        })
        .catchError((error) {
          SnackBarUtils.showSnackBar(
            context: context,
            appSettingsProvider: appSettingsProvider,
            message: 'Something went wrong',
            isError: true,
          );
        });
  }

  static Future<void> addUserToFireStore(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapshot = await getUserCollection().doc(uId).get();
    return querySnapshot.data();
  }
}
