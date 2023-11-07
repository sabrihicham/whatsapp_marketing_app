import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationsController with ChangeNotifier {
  Future<QuerySnapshot<Map<String, dynamic>>> getNotifications() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('toEmail', isEqualTo: 'all')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMessages(String email) {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('toEmail', isEqualTo: email)
        .get();
  }
}
