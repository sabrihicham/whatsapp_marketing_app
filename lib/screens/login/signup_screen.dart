import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_marketing/controller/langs.dart';
import 'package:whatsapp_marketing/screens/login/widgets/login_button.dart';
import 'package:whatsapp_marketing/screens/login/widgets/login_head_text.dart';
import 'package:whatsapp_marketing/screens/login/widgets/my_dropdown_menu.dart';
import 'package:whatsapp_marketing/screens/login/widgets/my_text_button.dart';
import 'package:whatsapp_marketing/screens/login/widgets/my_text_field.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../controller/sign_in_controller.dart';
import '../../util/images.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = 'signUpScreen';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController controller = context.watch<SignInController>();
    LangsController langsController = context.watch<LangsController>();
    final formKey = GlobalKey<FormState>();
    List<String> countries = [];
    List<String> codes = [];
    final passwordFocusNode = FocusNode();
    final showPasswordValidator = ValueNotifier(false);
    var passworValidator = GlobalKey();

    passwordFocusNode.addListener(() {
      showPasswordValidator.value = passwordFocusNode.hasFocus;

      if(passwordFocusNode.hasFocus) {
        Scrollable.ensureVisible(
          passworValidator.currentContext!,
          alignment: 0.3,
          duration: const Duration(milliseconds: 500),
        );
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: context.read<SignInController>().getCountriesSignUp(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                countries = [];
                codes = [];
                for (var country in snapshot.data!.docs) {
                  countries.add(country['countryName']);
                  codes.add(country['code']);
                }
                return Form(
                  key: formKey,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 45, 20, 10),
                    children: [
                      LoginHeadText(
                        title: langsController
                            .langs[langsController.lang ?? 'ar']!['newAcc']!,
                        hint: langsController
                            .langs[langsController.lang ?? 'ar']!['addInfo']!,
                      ),
                      Image.asset(MyImages.logoLink),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                        hintText: langsController
                            .langs[langsController.lang ?? 'ar']!['fullName']!,
                        icon: Icons.person_rounded,
                        controller: controller.userName,
                      ),
                      MyTextField(
                        hintText: langsController
                            .langs[langsController.lang ?? 'ar']!['projectName']!,
                        icon: Icons.info_rounded,
                        controller: controller.projectName,
                      ),
                      MyTextField(
                        hintText: langsController.langs[
                            langsController.lang ?? 'ar']!['emailAddress']!,
                        icon: Icons.email_rounded,
                        controller: controller.emailAddress,
                      ),
                      Column(
                        key: passworValidator,
                        children: [
                          MyTextField(
                            key: passworValidator,
                            hintText: langsController.langs[langsController.lang ?? 'ar']!['password']!,
                            icon: Icons.key_rounded,
                            controller: controller.password,
                            focusNode: passwordFocusNode,
                          ),
                          ValueListenableBuilder(
                            valueListenable: showPasswordValidator,
                            builder: (context, value, _) {
                              return Visibility(
                                visible: value,
                                child: FlutterPwValidator(
                                  controller: controller.password,
                                  minLength: 6,
                                  uppercaseCharCount: 1,
                                  lowercaseCharCount: 1,
                                  numericCharCount: 1,
                                  width: 400,
                                  height: 172,
                                  strings: (langsController.lang ?? 'ar') == 'ar'
                                    ? ArabicStrings() : null,
                                  onSuccess: () {
                                   controller.isPasswordValid = true;
                                  },
                                  onFail: () {
                                    controller.isPasswordValid = false;
                                  },
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                      MyTextField(
                        hintText: langsController.langs[
                            langsController.lang ?? 'ar']!['confirm_password']!,
                        icon: Icons.key_rounded,
                        controller: controller.confirmPassword,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              hintText: langsController
                                  .langs[langsController.lang ?? 'ar']!['phone']!,
                              icon: Icons.phone_rounded,
                              controller: controller.phoneNumber,
                            ),
                          ),
                          MyDropdownMenu(
                            width: 100,
                           selectedCode: context.read<SignInController>().selectedCode, 
                            codesItem: codes,
                            onChanged:
                                context.read<SignInController>().onChangedCode,
                            showSearchBox: true,
                          ),
                        ],
                      ),
                      MyDropdownMenu(
                        selectedCode: controller.selectedState,
                        width: 100,
                        codesItem: countries,
                        onChanged: context.read<SignInController>().onChangedCountry,
                        hintText: langsController.langs[langsController.lang ?? 'ar']!['country']!,
                        showSearchBox: true,
                      ),
                      MyTextField(
                        hintText: langsController.langs[langsController.lang ?? 'ar']!['city']!,
                        icon: Icons.location_city_rounded,
                        controller: controller.selectedCity,
                      ),
                      MyTextField(
                        hintText: langsController
                            .langs[langsController.lang ?? 'ar']!['orgType']!,
                        icon: Icons.type_specimen_rounded,
                        controller: controller.orgType,
                      ),
                      MyTextField(
                        hintText: langsController
                            .langs[langsController.lang ?? 'ar']!['orgLoc']!,
                        icon: Icons.not_listed_location_rounded,
                        controller: controller.orgLocation,
                      ),
                      MyTextField(
                        hintText: langsController
                            .langs[langsController.lang ?? 'ar']!['orgNum']!,
                        icon: Icons.numbers_rounded,
                        controller: controller.bissnusNumber,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LoginButton(
                        text: langsController
                            .langs[langsController.lang ?? 'ar']!['regAcc']!,
                        onPressed: () =>
                            context.read<SignInController>().signUp(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextButton(
                        text: langsController
                            .langs[langsController.lang ?? 'ar']!['haveAcc']!,
                        alignment: MainAxisAlignment.center,
                        onPressed: () => context.goBack(),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text('حدث خطأ'),
                );
              }
              return const Center(
                child: Text('حدث خطأ'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ArabicStrings implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'على الأقل - حرف';
  @override
  final String uppercaseLetters = '- حروف كبيرة';
  @override
  final String numericCharacters = '- أرقام';
  @override
  final String specialCharacters = '- رموز خاصة';
  @override
  String get lowercaseLetters => '- حروف صغيرة';
  @override
  String get normalLetters => '- حروف عادية';
}