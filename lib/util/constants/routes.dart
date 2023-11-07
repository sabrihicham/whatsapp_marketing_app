import 'package:flutter/material.dart';
import '../../screens/contact_us/contact_us.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/whatsapp/screens/whatsapp_screen.dart';

import '../../screens/contact_methods/screens/sms.dart';
import '../../screens/contact_methods/widgets/policy_terms.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/imported_messages/imported_messages.dart';
import '../../screens/imported_messages/messages_screen.dart';
import '../../screens/login/edit_profile.dart';
import '../../screens/login/forgot_pass.dart';
import '../../screens/login/signup_screen.dart';
import '../../screens/packages_screen/screens/packages_screen.dart';

class AppInit {
  static Map<String, Widget Function(BuildContext)> myRoutes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    ForgotScreen.routeName: (context) => const ForgotScreen(),
    SignUpScreen.routeName: (context) => const SignUpScreen(),
    HomeScreen.routeName: (context) => const HomeScreen(),
    ImportedMessagesScreen.routeName: (context) =>
        const ImportedMessagesScreen(),
    MessagesScreen.routeName: (context) => const MessagesScreen(),
    EditProfileScreen.routeName: (context) => const EditProfileScreen(),
    PackagesScreen.routeName: (context) => const PackagesScreen(),
    ContactUsScreen.routeName: (context) => const ContactUsScreen(),
    SMSScreen.routeName: (context) => const SMSScreen(),
    WhatsappScreen.routeName: (context) => const WhatsappScreen(),
    PolicyScreen.routeName: (context) => const PolicyScreen(),
    // ChatsScreen.routeName: (context) => ChatsScreen(),
    // PaymentRequestScreen.routeName: (context) => const PaymentRequestScreen(),
  };
}
