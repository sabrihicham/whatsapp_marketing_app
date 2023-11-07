import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helper/navigation.dart';

import '../helper/awesome_dialog.dart';

class FirestoreMethods {
  static void addUser({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String selectedCode,
    required String phone,
    String? phoneNumber2,
    required String projectName,
    required String cityLocation,
    required String stateLocation,
    String? statue,
    String? type,
    String? orgType,
    String? orgLocation,
    String? bussnissNumber,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(email).set({
      'email': email,
      'password': password,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'phone': phoneNumber,
      'selectedCode': phoneNumber,
      'phoneNumber2': phoneNumber2 ?? 'null',
      'city': cityLocation,
      'country': stateLocation,
      'projectName': projectName,
      'status': 'pending',
      'type': 'user',
      'orgLocation': orgLocation ?? 'null',
      'orgType': orgType ?? 'null',
      'bussnissNumber': bussnissNumber ?? 'null',
    }).catchError((error) {});
  }

  static void updateUser(
    BuildContext context, {
    required String email,
    required String displayName,
    required String phoneNumber,
    required String selectedCode,
    required String phone,
    String? phoneNumber2,
    required String projectName,
    required String cityLocation,
    required String stateLocation,
    String? orgType,
    String? orgLocation,
    String? bussnissNumber,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users
        .doc(email)
        .update({
          'email': email,
          'displayName': displayName,
          'phoneNumber': phoneNumber,
          'phone': phone,
          'selectedCode': selectedCode,
          'phoneNumber2': phoneNumber2 ?? 'null',
          'city': cityLocation,
          'country': stateLocation,
          'projectName': projectName,
          'status': 'pending',
          'type': 'user',
          'orgLocation': orgLocation ?? 'null',
          'orgType': orgType ?? 'null',
          'bussnissNumber': bussnissNumber ?? 'null',
        })
        .then(
          (value) => myAwesomeDialog(context, onTap: () {
            context.goBack();
          }, title: 'نجح', content: 'تم تحديث الحساب بنجاح'),
        )
        .catchError(
          (error) => myAwesomeDialog(context, onTap: () {
            context.goBack();
          }, title: 'فشل', content: 'فشل تحديث الحساب بسبب\n "$error"'),
        );
  }

  static void addContactUs(
    BuildContext context, {
    required String email,
    required String message,
    required String userName,
    required String phoneNumber,
    required String reson,
    required String whatsappNumber,
  }) async {
    CollectionReference contacts =
        FirebaseFirestore.instance.collection('contacts');

    await contacts
        .doc(email)
        .set({
          'email': email,
          'userName': userName,
          'phoneNumber': phoneNumber,
          'reson': reson,
          'message': message,
          'whatsappNumber': whatsappNumber,
        })
        .then(
          (value) => myAwesomeDialog(context, onTap: () {
            context.goBack();
          },
              title: 'تم بنجاح',
              content: 'تم ارسال الرسالة بنجاح سيتم الرد عليك باقرب وقت'),
        )
        .catchError(
          (error) => myAwesomeDialog(context, onTap: () {
            context.goBack();
          },
              title: 'فشل',
              content:
                  ' فشل ارسال الرسالة بسبب : "$error" اذا استمرت المشكلة تواصل معنا علي البريد الالكتروني'),
        );
  }

  static void addGroup(
    BuildContext context, {
    required String email,
    required String userName,
    required String phoneNumber,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('groups');

    await users
        .add({
          'email': email,
          'name': userName,
          'phoneNumber': phoneNumber,
        })
        .then(
          (value) => myAwesomeDialog(context, onTap: () {
            context.goBack();
          }, title: 'تم بنجاح', content: 'تم حفظ جهة الاتصال بنجاح'),
        )
        .catchError(
          (error) => myAwesomeDialog(context, onTap: () {
            context.goBack();
          },
              title: 'فشل',
              content:
                  ' فشل اضافة جهة الاتصال بسبب : "$error" اذا استمرت المشكلة تواصل معنا '),
        );
  }
}
