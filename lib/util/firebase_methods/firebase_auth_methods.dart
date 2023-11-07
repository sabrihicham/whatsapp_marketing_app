// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/login/login_screen.dart';
import 'firestore_methods.dart';
import '../helper/awesome_dialog.dart';
import '../helper/navigation.dart';

class FirebaseAuthMethods {
  static void signUp(
    BuildContext context, {
    required String email,
    required String password,
    required String userName,
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
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        FirestoreMethods.addUser(
          email: email,
          password: password,
          displayName: userName,
          phoneNumber: phoneNumber,
          phone: phoneNumber,
          selectedCode: selectedCode,
          projectName: projectName,
          cityLocation: cityLocation,
          stateLocation: stateLocation,
          bussnissNumber: bussnissNumber,
          orgLocation: orgLocation,
          orgType: orgType,
        );
        signOut(context);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        myAwesomeDialog(context, onTap: () {
          context.goBack();
        },
            title: 'تحذير',
            content: "كلمة السر ضعيفة جدا . من فضلك استخدم كلمة سر أخرى");
      } else if (e.code == 'email-already-in-use') {
        myAwesomeDialog(context, onTap: () {
          context.goBack();
        }, title: 'تحذير', content: 'هذا البريد الالكتروني مستخدم من قبل .');
      } else {
        myAwesomeDialog(context, onTap: () {
          context.goBack();
        }, title: 'خطأ', content: e.message.toString());
      }
    }
  }

  static User? get getCurrentUser => FirebaseAuth.instance.currentUser;

  static void updateUserData(
    BuildContext context, {
    required String email,
    required String userName,
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
    FirestoreMethods.updateUser(
      context,
      email: email,
      displayName: userName,
      phoneNumber: phoneNumber,
      phone: phone,
      selectedCode: selectedCode,
      projectName: projectName,
      cityLocation: cityLocation,
      stateLocation: stateLocation,
      bussnissNumber: bussnissNumber,
      orgLocation: orgLocation,
      orgType: orgType,
    );
  }

  static void login(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => FirebaseFirestore.instance
                .collection('users')
                .doc(email)
                .get()
                .then(
              (value) {
                if (value.data()!.containsValue('user')) {
                  context.goReplacementNamed(HomeScreen.routeName);
                } else {
                  myAwesomeDialog(
                    context,
                    title: 'خطا',
                    onTap: () async {
                      context.goBack();
                      await FirebaseAuth.instance.signOut();
                    },
                    content: 'هذا المستخدم ليس له صلاحية للدخول الي التطبيق',
                  );
                }
              },
            ),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        myAwesomeDialog(context, onTap: () {
          context.goBack();
        }, title: 'خطأ', content: 'لا يوجد حساب مربوط بهذا البريد الالكتروني');
      } else if (e.code == 'wrong-password') {
        myAwesomeDialog(context, onTap: () {
          context.goBack();
        }, title: 'خطأ', content: "كلمة السر خاطئة");
      } else {
        myAwesomeDialog(context, onTap: () {
          context.goBack();
        }, title: 'تحذير', content: e.message.toString());
      }
    }
  }

  static void signOut(BuildContext context) async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => context.goReplacementNamed(LoginScreen.routeName));
  }

  static void deleteAccount(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete().then(
        (value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(email)
              .delete()
              .then(
            (value) {
              context.goReplacementNamed(LoginScreen.routeName);
            },
          );
        },
      );
    } catch (e) {
      myAwesomeDialog(
        context,
        title: 'فشل',
        content: 'الرجاء محاولة حذف الحساب لاحقا',
        onTap: () => context.goBack(),
      );
    }
  }
}
