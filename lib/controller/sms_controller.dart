import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_marketing/controller/whatsapp/params/send_message_params.dart';
import '../util/helper/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';

import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../util/helper/get_location.dart';

class SMSController with ChangeNotifier {
  int selectedItem = 0;

  Iterable<Contact> myContacts = [];
  List<Contact> selectedContacts = [];
  bool isAllContactsSelected = false;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  void selectItem(int id) {
    selectedItem = id;
    notifyListeners();
  }

  void setSelectedContacts() {
    selectedContacts = [];
    notifyListeners();
  }

  void setContactsEmpty() {
    myContacts = [];
    notifyListeners();
  }

  void toggleContactSelection(Contact contact) {
    if (selectedContacts.contains(contact)) {
      selectedContacts.remove(contact);

      isAllContactsSelected = myContacts.length == selectedContacts.length;
    } else {
      selectedContacts.add(contact);
      isAllContactsSelected = myContacts.length == selectedContacts.length;
    }
    notifyListeners();
  }

  void selectAllContacts() {
    if (myContacts.length == selectedContacts.length) {
      selectedContacts = [];
      isAllContactsSelected = false;
    } else {
      selectedContacts = myContacts.toList();
      isAllContactsSelected = true;
    }

    notifyListeners();
  }

  Future<void> mySendSMS(BuildContext context) async {
    List<String> allNumbers = [];
    if (selectedContacts.isNotEmpty) {
      for (var contact in selectedContacts) {
        String phoneNumber =
            contact.phones!.isNotEmpty ? contact.phones!.first.value! : '';
        if (phoneNumber != '') {
          allNumbers.add(phoneNumber);
        }
      }
      try {
        await sendSMS(message: messageController.text, recipients: allNumbers)
            .then(
          (value) => myAwesomeDialog(context, onTap: () {
            context.goBack();
          }, title: 'تمت', content: value),
        );
      } catch (e) {
        if (e.toString().contains(
            'PlatformException(device_not_capable, The current device is not capable of sending text messages., A device may be unable to send messages if it does not support messaging or if it is not currently configured to send messages. This only applies to the ability to send text messages via iMessage, SMS, and MMS., null)')) {
          myAwesomeDialog(context, onTap: () {
            context.goBack();
          }, title: 'فشل', content: 'هذا الجهاز لا يدعم ارسال الرسائل النصية');
        }
      }
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'فشل', content: 'الرجاء اختيار جهة اتصال واحدة علي الاقل');
    }
  }

//location
  Location location = Location();
  Future<void> pickLocation() async {
    Position position = await determinePosition();
    location = Location(lat: position.latitude, long: position.longitude);
    print('${location.lat}     ${location.long}');
  }

  Future<void> sendSmsfromGroups(
      BuildContext context, List<Map<dynamic, dynamic>> numbers) async {
    List<String> allNumbers = [];
    if (numbers.isNotEmpty) {
      for (var number in numbers) {
        String phoneNumber =
            number['number'].isNotEmpty ? number['number'] : '';
        if (phoneNumber != '') {
          allNumbers.add(phoneNumber);
        }
      }

      try {
        if (linkController.text.isNotEmpty) {
          if (downloadLink!.isNotEmpty) {
            await sendSMS(
              message:
                  "${messageController.text}\n تسطتيع زيارة هذا الرابط ${linkController.text} \n لمعاينة الصورة زور هذا الرابط $downloadLink",
              recipients: allNumbers,
            ).then(
              (value) => myAwesomeDialog(context, onTap: () {
                context.goBack();
              }, title: 'تمت', content: value),
            );
          } else {
            await sendSMS(
              message:
                  "${messageController.text}\n تسطتيع زيارة هذا الرابط ${linkController.text}",
              recipients: allNumbers,
            ).then(
              (value) => myAwesomeDialog(context, onTap: () {
                context.goBack();
              }, title: 'تمت', content: value),
            );
          }
        } else {
          if (downloadLink!.isNotEmpty) {
            await sendSMS(
              message:
                  "${messageController.text}\n لمعاينة الصورة زور هذا الرابط $downloadLink",
              recipients: allNumbers,
            ).then(
              (value) => myAwesomeDialog(context, onTap: () {
                context.goBack();
              }, title: 'تمت', content: value),
            );
          } else {
            await sendSMS(
              message: messageController.text,
              recipients: allNumbers,
            ).then(
              (value) => myAwesomeDialog(context, onTap: () {
                context.goBack();
              }, title: 'تمت', content: value),
            );
          }
        }
      } catch (e) {
        if (e.toString().contains(
            'PlatformException(device_not_capable, The current device is not capable of sending text messages., A device may be unable to send messages if it does not support messaging or if it is not currently configured to send messages. This only applies to the ability to send text messages via iMessage, SMS, and MMS., null)')) {
          myAwesomeDialog(context, onTap: () {
            context.goBack();
          }, title: 'فشل', content: 'هذا الجهاز لا يدعم ارسال الرسائل النصية');
        }
      }
    }
  }

  Future<void> getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      var contacts = await ContactsService.getContacts();
      myContacts = contacts;

      notifyListeners();
    } else {
      requestPermissions();
      getContacts();
    }
  }

  Future<void> requestPermissions() async {
    final PermissionStatus permissionStatus =
        await Permission.contacts.request();

    if (permissionStatus != PermissionStatus.granted) {
      throw Exception('Permission denied');
    }

    final PermissionStatus smsPermissionStatus = await Permission.sms.request();

    if (smsPermissionStatus != PermissionStatus.granted) {
      throw Exception('SMS permission denied');
    }
  }

  Future<void> uploadContacts(BuildContext context, String email) async {
    if (selectedContacts.isNotEmpty) {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('groups');

      await collectionReference.add(
        {
          'email': email,
          'groupName': groupNameController.text,
        },
      ).then(
        (value) {
          for (var contact in selectedContacts) {
            String phoneNumber =
                contact.phones!.isNotEmpty ? contact.phones!.first.value! : '';
            value.collection('numbers').add(
              {
                'group': value.id,
                'name': contact.displayName ?? '',
                'number': phoneNumber,
              },
            );
          }
        },
      );
      // ignore: use_build_context_synchronously
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'تمت', content: 'تم انشاء المجموعه و رفعها بنجاح');
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'فشل', content: 'من فضلك اختر اي اسم');
    }
  }

  //upload image
  Reference storageReference = FirebaseStorage.instance.ref('/sms');
  late XFile? image;
  final ImagePicker picker = ImagePicker();
  late File finalImage;
  String? downloadLink;
  bool isloading = false;
  bool desableButton = true;

  Future<void> getImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    isloading = true;
    notifyListeners();
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      isloading = false;
    } else {
      finalImage = File(image!.path);

      // ignore: use_build_context_synchronously
      addImageToFirebase(context);
    }
  }

  void addImageToFirebase(BuildContext context) async {
    Random random = Random();
    double randomNumber = random.nextDouble() * 1000000000;
    Reference ref = storageReference.child(randomNumber.toString());

    try {
      await ref.putFile(finalImage).whenComplete(
            () => ref.getDownloadURL().then(
              (value) {
                downloadLink = value;

                myAwesomeDialog(context, title: 'title', content: 'content',
                    onTap: () {
                  isloading = false;
                  context.goBack(); // desableButton = false;
                  notifyListeners();
                });
              },
            ),
          );
    } catch (e) {
      //
    }
  }
}
