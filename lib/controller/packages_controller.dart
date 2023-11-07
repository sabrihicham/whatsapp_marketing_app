import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PackagesController with ChangeNotifier {
  Future<QuerySnapshot<Map<String, dynamic>>> getPackages() {
    return FirebaseFirestore.instance.collection('prices').get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getMethods() {
    return FirebaseFirestore.instance.collection('paymetMethods').get();
  }
}
