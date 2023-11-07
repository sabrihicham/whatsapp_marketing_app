import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../controller/langs.dart';
import '../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import 'widgets/login_button.dart';
import 'widgets/my_dropdown_menu.dart';
import 'widgets/my_text_field.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../../controller/sign_in_controller.dart';

class EditProfileScreen extends StatelessWidget {
  static String routeName = 'edit_profileScreen';

  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignInController signInControllerVars = context.watch<SignInController>();
    SignInController signInControllerFuncs = context.read<SignInController>();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    LangsController langsController = context.watch<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              langsController.langs[langsController.lang ?? 'ar']!['edit']!),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: FutureBuilder(
          future: context
              .read<SignInController>()
              .getUser(firebaseAuth.currentUser!.email, context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "لقد حدث خطأ غير متوقع الرجاء المحاولة مرة أخري",
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 45, 20, 10),
                  children: [
                    MyTextField(
                      hintText: langsController
                          .langs[langsController.lang ?? 'ar']!['userName']!,
                      icon: Icons.person_rounded,
                      controller: signInControllerVars.userName,
                    ),
                    MyTextField(
                      hintText: langsController
                          .langs[langsController.lang ?? 'ar']!['projectName']!,
                      icon: Icons.info_rounded,
                      controller: signInControllerVars.projectName,
                    ),
                    MyTextField(
                      hintText: langsController.langs[
                          langsController.lang ?? 'ar']!['emailAddress']!,
                      icon: Icons.email_rounded,
                      controller: signInControllerVars.emailAddress,
                    ),
                    MyTextField(
                      hintText: langsController
                          .langs[langsController.lang ?? 'ar']!['phone']!,
                      icon: Icons.phone_rounded,
                      controller: signInControllerVars.phoneNumber,
                    ),
                    MyDropdownMenu(
                      width: 100,
                      codesItem: context.watch<SignInController>().states,
                      onChanged: signInControllerFuncs.onChangedCountry,
                      selectedCode: signInControllerVars.selectedState,
                      hintText: langsController
                          .langs[langsController.lang ?? 'ar']!['country']!,
                      showSearchBox: true,
                    ),
                    MyTextField(
                      hintText: langsController
                          .langs[langsController.lang ?? 'ar']!['city']!,
                      icon: Icons.location_city_rounded,
                      controller: signInControllerVars.selectedCity,
                    ),
                    MyTextField(
                      hintText: langsController
                          .langs[langsController.lang ?? 'ar']!['orgType']!,
                      icon: Icons.type_specimen_rounded,
                      controller: signInControllerVars.orgType,
                    ),
                    MyTextField(
                      hintText: langsController
                          .langs[langsController.lang ?? 'ar']!['orgLoc']!,
                      icon: Icons.not_listed_location_rounded,
                      controller: signInControllerVars.orgLocation,
                    ),
                    MyTextField(
                      hintText: langsController
                          .langs[langsController.lang ?? 'ar']!['orgNum']!,
                      icon: Icons.numbers_rounded,
                      controller: signInControllerVars.bissnusNumber,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LoginButton(
                      text: langsController
                          .langs[langsController.lang ?? 'ar']!['save']!,
                      onPressed: () =>
                          signInControllerFuncs.updateUserData(context),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              } else {
                return const Text('ليس لديك اي رسائل');
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
