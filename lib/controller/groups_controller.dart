import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupsController with ChangeNotifier {
  List<Map> numbers = [];
  QuerySnapshot<Map<String, dynamic>>? docs;
  Future<QuerySnapshot<Map<String, dynamic>>> getGroups(String email) async {
    numbers = [];

    await fetchDocuments(email);

    return docs!;
  }

  Future<void> fetchDocuments(email) async {
    numbers = [];

    docs = await FirebaseFirestore.instance
        .collection('groups')
        .where('email', isEqualTo: email)
        .get();

    for (QueryDocumentSnapshot mainDoc in docs!.docs) {
      QuerySnapshot nestedSnapshot = await FirebaseFirestore.instance
          .collection('groups')
          .doc(mainDoc.id)
          .collection('numbers')
          .get();

      for (QueryDocumentSnapshot nestedDoc in nestedSnapshot.docs) {
        numbers.add(
          {
            'group': mainDoc.id,
            'number': nestedDoc.get('number'),
            'name': nestedDoc.get('name'),
          },
        );
      }
    }
  }
}
