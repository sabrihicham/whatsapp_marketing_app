import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangsController with ChangeNotifier {
  String? lang;

  late SharedPreferences prefs;

  LangsController() {
    lang ??= 'ar';
  }

  Map<String, Map<String, String>> langs = {
    'ar': {
      'homeTitle': 'ابدأ في تسويق مشروعك!',
      'whatsapp': 'واتساب',
      'whatsapp_biss': 'واتساب للأعمال',
      'sms': 'رسائل نصية',
      'ad': 'شاهد طريقة استخدام التطبيق ؟',
      'menue': 'القائمة',
      'edit': 'تعديل الصفحة الشخصية',
      'imported': 'الرسائل الواردة',
      'noti': 'الاشعارات',
      'subscribe': 'اشتراك بالباقة',
      'share': 'شارك مع الأصدقاء',
      'change_lang': '[العربية] اللغة',
      'contact': 'تواصل معنا',
      'policy': 'سياسية التطبيق',
      'sign_out': 'تسجيل الخروج',
      'delete': 'حذف الحساب',
      //contact us
      'contact_us_head':
          'قم بوضع رسالتك وستقوم الإدارة بالرد عليك في أسرع وقت ممكن',
      'whatsapp_contact': 'تواصل معنا عن طريق الواتساب !',
      'phone_contact': 'تواصل معنا عن طريق الهاتف !',
      'userName': 'اسم المستخدم',
      'emailAddress': 'البريد الإلكتروني',
      'phone': 'رقم الهاتف',
      'phone_whatsapp': 'رقم الواتساب',
      'contact_reson': 'سبب التواصل',
      'message': 'اكتب رساتلك هنا...',
      'send': 'إرسال',
      'confirm': 'تأكيد',
      //  edit
      'projectName': 'اسم المشروع',
      'country': 'الدولة',
      'city': 'المدينة',
      'orgType': 'نوع المؤسسة (اختياري)',
      'orgLoc': 'موقع المؤسسة (اختياري)',
      'orgNum': 'الرقم التجاري (اختياري)',
      //login
      'save': 'حفظ',
      'welcome': 'مرحبًا بعودتك!',
      'password': 'كلمة المرور',
      'confirm_password': 'كلمة المرور',
      'resetQ': 'إعادة تعيين كلمة المرور ؟',
      'login': 'تسجيل دخول',
      'dontacc': 'ليس لدي حساب ؟',
      //sms
      'lanch_ad': 'اطلق إعلانك بكل سهولة',
      'dalil_phone': 'دليل الهاتف',
      'link': 'الرابط',
      'select': 'اختيار الوجهة',
      'add_photo': 'إضافة صورة',
      'photo': 'تم إضافة الصورة بنجاح',
      'select_all': 'تحديد الكل',
      'add_loc': 'اضافة الموقع',
      'send_new_msg': 'إرسال رسالة جديدة',
      //packages and plans
      'code': 'كود خصم',
      'use_code': 'استخدام كود خصم',
      'code_notice':
          'عند استخدام كود خصم سيتم خصم جزء معين من المبلغ الكلي لك ',
      'enter_code': 'ادخل كود الخصم',
      'start_code': 'بدأ الخصم',
      'skip': 'تخطي',
      'add_plan': 'إضافة باقة جديدة',
      'currunt_plans': 'الباقات الحالية',
      'enable': 'تفعيل',
      'pay_request': 'طلب الدفع',
      'pay_request_notice':
          'يمكنك طلب الدفع من قبل الحسابات التالية و بإكتمال الدفع فقط يمكنك إرفاق الإيصال',

      'pay_now': 'ادفع الان',

      'send_success': 'تم الإرسال',
      'send_success_msg': 'تهانينا تم إرسال الرسالة بنجاح للوجهة المحددة',
      'sending': 'جاري الإرسال...',
      'select_dis': 'اختر الوجهة',
      'all': 'الكل',
      'chats': 'الدردشات',
      'groups': 'المجموعات',
      'selct_all': 'تحديد الكل',
      'select_all_chats': 'تحديد كل الدردشات',
      'select_all_groups': 'تحديد كل المجموعات',

      'try_again': 'أعد المحاولة',
      'error_message': 'حدث خطأ ما! الرجاء أعد المحاولة',
      'error': 'خطأ',
      'cancel': 'إلغاء',
      'loc_add': 'تم تحديد الموقع',
      'doc_uploaded': 'تم رفع المستند',

      'refresh': 'تحديث',
      'register_account': 'تسجيل الحساب',
      'first_message':
          '- قم بمسح الرمز من حسابك في واتساب، بعدها قم بتسجيل الحساب خلال 15 ثانية.',
      'second_message':
          '- في حال كان الرمز غير صالح، قم بتحديث الرمز ثم أعد المحاولة.',
      'clear_data': 'مسح البيانات',
      'data_clear_faild': 'فشل مسح البيانات',
      'haveAcc': 'لدي حساب بالفعل ؟',
      'regAcc': 'إنشاء حساب',
      'fullName': 'الاسم الثلاثي',
      'addInfo': 'اضافة المعلومات الشخصية',
      'newAcc': 'حساب جديد',
      'resetP': 'إعادة تعيين',
      'newPass': 'كلمة مرور جديدة',
      'entEmail':
          'قم بإدخال بريدك المسجل وقم بفحصه لإعادة تعيين كلمة مرور جديدة',
    },
    'en': {
      'homeTitle': 'Start to marketing your project!',
      'whatsapp': 'WhatsApp',
      'whatsapp_biss': 'WhatsApp Business',
      'sms': 'SMS',
      'ad': 'How to use App?',
      'menue': 'Menu',
      'edit': 'Edit Profile',
      'imported': 'Recieved Messages',
      'noti': 'Notifications',
      'subscribe': 'Subscribe in package',
      'share': 'Share',
      'change_lang': 'Language [english]',
      'contact': 'Contact Us',
      'policy': 'Policies & Terms',
      'sign_out': 'SignOut',
      'delete': 'Delete Account',
      //contact us
      'save': 'save',
      'welcome': 'Welcome Back!',
      'login': 'Login',
      'contact_us_head': 'Put your message here and we will respond you!',
      'whatsapp_contact': 'contact us on ًWhatsApp !',
      'phone_contact': 'contact us on phone !',
      'userName': 'User Name',
      'emailAddress': 'Email Address',
      'phone': 'Phone Number',
      'phone_whatsapp': 'Whatsapp Number',
      'contact_reson': 'Contact Reason',
      'message': 'write your message here ..',
      'send': 'Send',
      'confirm': 'Confirm',
      //  edit
      'projectName': 'Project Name',
      'country': 'Country',
      'city': 'City',
      'orgType': 'Org Type (Not Required)',
      'orgLoc': 'Org Location (Not Required)',
      'orgNum': 'bissnuss Number (Not Required)',
      //sms
      'dontacc': "Don't have an account?",
      'lanch_ad': 'launch Your Add easily',
      'dalil_phone': 'from Contacts',
      'link': 'link',
      'select': 'select',
      'add_photo': 'add photo',
      'photo': 'photo added succecfully',
      'select_all': 'select All',
      'add_loc': 'add location',
      'send_new_msg': 'send new message',
      //packages and plans
      'code': 'Discount Code',
      'use_code': 'use Discount Code',
      'code_notice':
          'when you use a Discount Code, A particular part of the total amount will be deducted for you',
      'enter_code': 'enter Discount Code',
      'start_code': 'Start Discount',
      'skip': 'Skip',
      'add_plan': 'Subscribe in package',
      'currunt_plans': 'Currunt Plans',
      'enable': 'Enable',
      'pay_request': 'payment request',
      'pay_request_notice':
          'You can request a payment from the following accounts and prepare only you can attach the receipt',
      'pay_now': 'Pay Now',

      'send_success': 'Send Success',
      'send_success_msg': 'Congratulations, the message has been sent successfully to the selected destination',
      'sending': 'sending...',
      'select_dis': 'Select Desination',
      'all': 'All',
      'chats': 'Chats',
      'groups': 'Groups',
      'selct_all': 'Select All',
      'select_all_chats': 'Select All Chats',
      'select_all_groups': 'Select All Groups',

      'try_again': 'Try again',
      'error_message': 'Some thing went wrong! Try again later.',
      'error': 'Error',
      'cancel': 'Cancel',
      'loc_add': 'Location Added',
      'doc_uploaded': 'Document uploaded',

      'refresh': 'Refresh',
      'register_account': 'Register Account',
      'first_message':
          '- scan the qr code from your whatsapp account, then register account in 15 seconds.',
      'second_message':
          '- in case if the code is not valid, then refresh the code and rescan.',
      'clear_data': 'Clear Data',
      'data_clear_faild': 'Data Clear Faild',
      'haveAcc': 'I have an account?',
      'regAcc': 'Create Account',
      'fullName': 'Full Name',
      'addInfo': 'Add personal Info',
      'newAcc': 'New Account',
      'resetP': 'Reset',
      'password': 'Password',
      'newPass': 'New Password',
      'confirm_password': 'Confirm Password',
      'entEmail': 'Enter your email to reset password',
      'resetQ': 'Reset Password?',
    },
  };
  
  setlang() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('lang')) {
      lang = prefs.getString('lang')!;
    } else {
      prefs.setString('lang', 'ar');
    }
    notifyListeners();
  }

  changeLang() async {
    prefs = await SharedPreferences.getInstance();
    
    if (prefs.containsKey('lang')) {
      lang = prefs.getString('lang')!;

      if (lang == 'ar') {
        prefs.setString('lang', 'en');
      } else {
        prefs.setString('lang', 'ar');
      }

      lang = prefs.getString('lang')!;
    } else {
      prefs.setString('lang', 'ar');
    }

    notifyListeners();
  }

  changeLangAR() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', 'ar');
  }
}
