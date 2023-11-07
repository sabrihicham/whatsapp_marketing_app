import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_marketing/screens/contact_us/contact_us.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../../../controller/sign_in_controller.dart';
import '../../contact_methods/widgets/policy_terms.dart';
import '../../imported_messages/messages_screen.dart';
import '../../login/edit_profile.dart';
import '../../login/widgets/login_button.dart';
import '../../packages_screen/screens/packages_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.watch<LangsController>();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    return LayoutBuilder(
      builder: (p0, p1) {
        return ListView(
          padding: const EdgeInsets.only(
            top: 45,
            right: 10,
            left: 10,
          ),
          children: [
            Text(
              langsController.langs[langsController.lang ?? 'ar']!['menue']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ListItem(
              text:
                  langsController.langs[langsController.lang ?? 'ar']!['edit']!,
              onTap: () {
                context.goToNamed(EditProfileScreen.routeName);
              },
            ),
            ListItem(
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['imported']!,
              onTap: () => context.goToNamed(MessagesScreen.routeName),
            ),
            ListItem(
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['subscribe']!,
              onTap: () => context.goToNamed(PackagesScreen.routeName),
            ),
            // ListItem(
            //   text: 'القوائم',
            //   onTap: () => context.goTo(const GroupsScreen()),
            // ),
            ListItem(
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['share']!,
              icon: Icons.share_rounded,
              onTap: () {
                Share.share(
                  'مرحبا انا استخدم تطبيق جديد استطيع ان ارسل العديد من الرسائل الي العديد من المسخدمين مرة واحدة عن طريق الواتساباو التليجرام او الرسائل النصية حمله الان و جربه ايضا "سوف نضع رابط التطبيق هنا "',
                );
              },
            ),
            ListItem(
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['change_lang']!,
              onTap: () => context.read<LangsController>().changeLang(),
            ),
            ListItem(
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['contact']!,
              onTap: () => context.goToNamed(ContactUsScreen.routeName),
            ),
            ListItem(
                text: langsController.langs[langsController.lang ?? 'ar']!['policy']!,
                onTap: () {
                  context.goToNamed(PolicyScreen.routeName);
                }),
            const SizedBox(
              height: 35,
            ),
            LoginButton(
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['sign_out']!,
              width: p1.maxWidth * (2 / 3),
              onPressed: () {
                context.read<SignInController>().signOut(context);
                // context.read<LangsController>().changeLangAR();
              },
            ),
            const SizedBox(
              height: 15,
            ),
            LoginButton(
              text: langsController
                  .langs[langsController.lang ?? 'ar']!['delete']!,
              width: p1.maxWidth * (2 / 3),
              onPressed: () {
                context
                    .read<SignInController>()
                    .deleteAccount(context, firebaseAuth.currentUser!.email!);
                // context.read<LangsController>().changeLangAR();
              },
            ),
          ],
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;
  const ListItem({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                icon ?? Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
