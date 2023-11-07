import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import '../util/helper/navigation.dart';

import '../util/helper/awesome_dialog.dart';

class UploadImageController with ChangeNotifier {
  Reference storageReference = FirebaseStorage.instance.ref('/payments');
  late XFile? image;
  final ImagePicker picker = ImagePicker();
  late File finalImage;
  String? downloadLink;
  bool isloading = false;
  bool desableButton = true;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    isloading = true;
    notifyListeners();
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
    } else {
      finalImage = File(image!.path);
      addImageToFirebase();
    }
  }

  void addImageToFirebase() {
    Random random = Random();
    double randomNumber = random.nextDouble() * 1000000000;
    Reference ref = storageReference.child(randomNumber.toString());

    try {
      ref
          .putFile(finalImage)
          .whenComplete(() => ref.getDownloadURL().then((value) {
                downloadLink = value;
                isloading = false;
                desableButton = false;
                notifyListeners();
              }));
    } catch (e) {
      //
    }
  }

  void addImageToFirestore(BuildContext context,
      {required String price, required String discountCode}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    CollectionReference paymentRequests =
        FirebaseFirestore.instance.collection('paymentRequests');
    if (downloadLink != null) {
      await paymentRequests
          .add({
            'email': firebaseAuth.currentUser!.email,
            'imageLink': downloadLink,
            'status': 'pending',
            'price': price,
            'discountCode': discountCode,
          })
          .then(
            (value) => myAwesomeDialog(context, onTap: () {
              context.goBack();
            },
                title: 'نجح',
                content:
                    'تم ارسال الوصل بنجاح انتظر التواصل معك من قبل المشرف'),
          )
          .catchError(
            (error) => myAwesomeDialog(context, onTap: () {
              context.goBack();
            }, title: 'فشل', content: 'فشل ارسال الوصل بسبب \n "$error"'),
          );
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'فشل', content: 'يجب اختيار الصورة و رفعها اولا');
    }
  }
}
