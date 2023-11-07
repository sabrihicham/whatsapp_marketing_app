import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/firebase_methods/firebase_auth_methods.dart';
import '../util/helper/awesome_dialog.dart';
import '../util/helper/navigation.dart';

class SignInController with ChangeNotifier {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController projectName = TextEditingController();
  TextEditingController orgType = TextEditingController();
  TextEditingController orgLocation = TextEditingController();
  TextEditingController bissnusNumber = TextEditingController();
  TextEditingController selectedCity = TextEditingController();
  // pass validator
  bool isPasswordValid = false;
  //State code controller
  List<String> codes = [];
  List<String> states = [];
  String selectedCode = '+20';
  String phone = '';

  late SharedPreferences prefs;

  void onChangedCode(String? value) {
    selectedCode = value!;
    notifyListeners();
  }

  //location
  // String? stateName, cityName;

  String selectedState = 'مصر';
  
  void onChangedCountry(String? value) {
    selectedState = value!;
  }

  //
  void signUp(BuildContext context) {
    if (selectedCity.text.isNotEmpty) {
      if (emailAddress.text.isNotEmpty &&
          userName.text.isNotEmpty &&
          phoneNumber.text.isNotEmpty &&
          projectName.text.isNotEmpty &&
          selectedState != '' &&
          selectedCity.text.isNotEmpty) {
        if (isPasswordValid && password.text == confirmPassword.text) {
          if (!(userName.text.trim().split(' ').length < 3)) {
            FirebaseAuthMethods.signUp(
              context,
              email: emailAddress.text,
              password: password.text,
              userName: userName.text,
              phoneNumber: '$selectedCode${phoneNumber.text}',
              phone: phoneNumber.text,
              selectedCode: selectedCode,
              projectName: projectName.text,
              cityLocation: selectedCity.text,
              stateLocation: selectedState,
              bussnissNumber: bissnusNumber.text,
              orgLocation: orgLocation.text,
              orgType: orgType.text,
            );
          } else {
            myAwesomeDialog(context, onTap: () {
              context.goBack();
            }, title: 'تحذير', content: 'يجب أن يكون اسم المستخدم ثلاثي');
          }
        } else {
          myAwesomeDialog(context, onTap: () {
            context.goBack();
          },
              title: 'تحذير',
              content: 'تأكد من كتابة كلمة السر مرة اخري بطريقة صحيحة');
        }
      } else {
        myAwesomeDialog(context, onTap: () {
          context.goBack();
        }, title: 'تحذير', content: 'من فضلك ادخل جميع المدخلات المطلوبة');
      }
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'تحذير', content: 'من فضلك ادخل المدينة ');
    }
  }

  Future<void> signOut(BuildContext context) async {
    FirebaseAuthMethods.signOut(context);
    (await SharedPreferences.getInstance()).clear();
  }

  Future<void> deleteAccount(BuildContext context, String email) async {
    FirebaseAuthMethods.deleteAccount(context, email);
    (await SharedPreferences.getInstance()).clear();
  }

  void login(BuildContext context) async {
    if (emailAddress.text.isNotEmpty && password.text.isNotEmpty) {
      FirebaseAuthMethods.login(emailAddress.text, password.text, context);
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'تحذير', content: 'من فضلك ادخل البريد الالكتروني و كلمة السر');
    }

    // context.goToNamed(HomeScreen.routeName);
  }

  void returnPassword(BuildContext context) {
    if (emailAddress.text.isNotEmpty) {
      FirebaseAuthMethods.login(emailAddress.text, password.text, context);
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'تحذير', content: 'من فضلك ادخل البريد الالكتروني');
    }
  }

  Future<Map> getUser(email, BuildContext context) async {
    await FirebaseFirestore.instance.collection('users').doc(email).get().then(
      (value) {
        emailAddress.text = value.data()!['email'];
        userName.text = value.data()!['displayName'];
        phone = value.data()!['phone'];
        phoneNumber.text = '';
        phoneNumber.text = phone;

        selectedCode = value.data()!['selectedCode'];
        projectName.text = value.data()!['projectName'];
        orgType.text = value.data()!['orgType'];
        orgLocation.text = value.data()!['orgLocation'];
        bissnusNumber.text = value.data()!['bussnissNumber'];
        selectedCity.text = value.data()!['city'];
        selectedState = value.data()!['country'];
        getCountries();
        return value;
      },
    );
    return {};
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCountriesSignUp() async {
    final countries = await FirebaseFirestore.instance.collection('countries').get();
    return countries;
  }

  Future getCountries() async {
    await FirebaseFirestore.instance
        .collection('countries')
        .get()
        .then((value) {
      states = [];
      codes = [];
      for (var country in value.docs) {
        states.add(country['countryName']);
        codes.add(country['code']);
      }
      return value;
    });
  }

  void updateUserData(BuildContext context) {
    if (selectedCity.text.isNotEmpty) {
      if (emailAddress.text.isNotEmpty &&
          userName.text.isNotEmpty &&
          phoneNumber.text.isNotEmpty &&
          projectName.text.isNotEmpty &&
          selectedState != '' &&
          selectedCity.text.isNotEmpty) {
        if (!(userName.text.trim().split(' ').length < 3)) {
          FirebaseAuthMethods.updateUserData(
            context,
            email: emailAddress.text,
            userName: userName.text,
            phoneNumber: '$selectedCode${phoneNumber.text}',
            phone: phoneNumber.text,
            selectedCode: selectedCode,
            projectName: projectName.text,
            cityLocation: selectedCity.text,
            stateLocation: selectedState,
            bussnissNumber: bissnusNumber.text,
            orgLocation: orgLocation.text,
            orgType: orgType.text,
          );
        } else {
          myAwesomeDialog(context, onTap: () {
            context.goBack();
          }, title: 'تحذير', content: 'يجب أن يكون اسم المستخدم ثلاثي');
        }
      } else {
        myAwesomeDialog(context, onTap: () {
          context.goBack();
        }, title: 'تحذير', content: 'من فضلك ادخل جميع المدخلات المطلوبة');
      }
    } else {
      myAwesomeDialog(context, onTap: () {
        context.goBack();
      }, title: 'تحذير', content: 'من فضلك ادخل المدينة ');
    }
  }
}
