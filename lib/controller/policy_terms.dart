import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PolicyAndTermsController with ChangeNotifier {
  Future<DocumentSnapshot<Map<String, dynamic>>> getPolicy() {
    return FirebaseFirestore.instance
        .collection('links')
        .doc('policy_link')
        .get();
  }
}
