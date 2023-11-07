import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../controller/banar_controller.dart';
import '../../controller/contact_us_controller.dart';
import '../../controller/policy_terms.dart';
import '../../controller/discount_controller.dart';
import '../../controller/groups_controller.dart';
import '../../controller/langs.dart';
import '../../controller/notifications_controller.dart';
import '../../controller/packages_controller.dart';
import '../../controller/sign_in_controller.dart';
import '../../controller/sms_controller.dart';
import '../../controller/upload_image_controller.dart';

List<SingleChildWidget> myProviders() => [
      ChangeNotifierProvider<SignInController>(
        create: (context) => SignInController(),
      ),
      ChangeNotifierProvider<ContactUsController>(
        create: (context) => ContactUsController(),
      ),
      ChangeNotifierProvider<PackagesController>(
        create: (context) => PackagesController(),
      ),
      ChangeNotifierProvider<NotificationsController>(
        create: (context) => NotificationsController(),
      ),
      ChangeNotifierProvider<BannarController>(
        create: (context) => BannarController(),
      ),
      ChangeNotifierProvider<YoutubeLinksController>(
        create: (context) => YoutubeLinksController(),
      ),
      ChangeNotifierProvider<UploadImageController>(
        create: (context) => UploadImageController(),
      ),
      ChangeNotifierProvider<GroupsController>(
        create: (context) => GroupsController(),
      ),
      ChangeNotifierProvider<SMSController>(
        create: (context) => SMSController(),
      ),
      ChangeNotifierProvider<DisCountController>(
        create: (context) => DisCountController(),
      ),
      ChangeNotifierProvider<LangsController>(
        create: (context) => LangsController(),
      ),
      ChangeNotifierProvider<PolicyAndTermsController>(
        create: (context) => PolicyAndTermsController(),
      ),
    ];
