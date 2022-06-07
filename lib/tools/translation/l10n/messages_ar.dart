import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

final _keepAnalysisHappy = Intl.defaultLocale;

typedef MessageIfAbsent = Function(String messageStr, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  get localeName => 'ar';

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => <String, Function>{
        "email": MessageLookupByLibrary.simpleMessage("البريد الاكترونى"),
        "pleaseEnterYourEmail": MessageLookupByLibrary.simpleMessage(
            "من فضلك ادخل البريد الالكترونى"),
        "pleaseEnterCorrectEmail": MessageLookupByLibrary.simpleMessage(
            "من فضلك ادخل بريد الكترونى صحيح"),
        "emailDoesNotFound":
            MessageLookupByLibrary.simpleMessage("البريد الالكترونى غير موجود"),
        "pleaseEnterYourUserName":
            MessageLookupByLibrary.simpleMessage("من فضلك ادخل اسم المستخدم"),
        "pleaseEnterYourPassword":
            MessageLookupByLibrary.simpleMessage("من فضلك ادخل كلمة المرور"),
        "pleaseConfirmYourPassword":
            MessageLookupByLibrary.simpleMessage("من فضلك أكد كلمة المرور"),
        "pleaseEnterCorrectUserName": MessageLookupByLibrary.simpleMessage(
            "من فضلك ادخل اسم مستخدم صحيح"),
        "userNameDoesNotFound":
            MessageLookupByLibrary.simpleMessage("اسم المستخدم غير موجود"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("تآكيد كلمة المرور"),
        "passwordIsNotCorrect":
            MessageLookupByLibrary.simpleMessage("كلمة المرور غير صحيحة"),
        "emailOrPasswordIsNotCorrect": MessageLookupByLibrary.simpleMessage(
            "البريد الالكترونى او كلمة المرور غير صحيحة"),
        "passwordDoesNotMatch":
            MessageLookupByLibrary.simpleMessage("كلمة المرور غير متطابقة"),
        "appVersion": MessageLookupByLibrary.simpleMessage("نسخة 1.0.0"),
        "firstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
        "lastName": MessageLookupByLibrary.simpleMessage("الاسم الأخير"),
        "pleaseEnterYourFirstName":
            MessageLookupByLibrary.simpleMessage("من فضلك ادخل الاسم الأول"),
        "pleaseEnterYourLastName":
            MessageLookupByLibrary.simpleMessage("من فضلك ادخل الاسم الأخير"),
        "signUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "userName": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
        "forgotPasswordWithQuestionMark":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "ifYouDoNotHaveAccountSignUp": MessageLookupByLibrary.simpleMessage(
            "إذا لم يكن لديك حساب قم بالتسجيل"),
        "or": MessageLookupByLibrary.simpleMessage("أو"),
        "createNewAccount":
            MessageLookupByLibrary.simpleMessage("تسجيل حساب جديد"),
        "changeLanguage": MessageLookupByLibrary.simpleMessage("تغيير اللغة"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "pleaseWait": MessageLookupByLibrary.simpleMessage("برجاء الانتظار"),
        "areYouSureOfExit":
            MessageLookupByLibrary.simpleMessage("هل انت متأكد من الخروج؟"),
        "yes": MessageLookupByLibrary.simpleMessage("نعم"),
        "no": MessageLookupByLibrary.simpleMessage("لا"),
        "ifYouDoNotHaveAnAccountSignUp": MessageLookupByLibrary.simpleMessage(
            "إذا لم يكن لديك حساب قم بالتسجيل"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "myAccount": MessageLookupByLibrary.simpleMessage("حسابى"),
        "saved": MessageLookupByLibrary.simpleMessage("المحفوظات"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("رفع صورة"),
        "publish": MessageLookupByLibrary.simpleMessage("نشر"),
        "ignore": MessageLookupByLibrary.simpleMessage("تجاهل"),
        "writeACommentAboutThePhoto":
            MessageLookupByLibrary.simpleMessage("اكتب تعليقاً حول الصورة"),
        "thePasswordProvidedIsTooWeak": MessageLookupByLibrary.simpleMessage(
            "كلمة المرور المقدمة ضعيفة للغاية"),
        "theAccountAlreadyExistsForThatEmail":
            MessageLookupByLibrary.simpleMessage(
                "الحساب موجود بالفعل لهذا البريد الإلكتروني"),
        "invalidCredentials":
            MessageLookupByLibrary.simpleMessage("بيانات التسجيل غير صالحة"),
        "errorConnectingWithServer":
            MessageLookupByLibrary.simpleMessage("خطأ فى الاتصال بالخادم"),
        "errorConnectingToTheInternet":
            MessageLookupByLibrary.simpleMessage("خطأ فى الاتصال بالانترنت"),
        "accountCreatedSuccessfullyAnEmailHasBeenSentToVerifyYourAccount":
            MessageLookupByLibrary.simpleMessage(
                "تم إنشاء الحساب بنجاح ، وتم إرسال بريد إلكتروني للتحقق من حسابك"),
        "accountNotVerifiedPleaseFollowInstructionsOnEmailToVerifyYourAccount":
            MessageLookupByLibrary.simpleMessage(
                "لم يتم التحقق من الحساب ، يرجى اتباع التعليمات الموجودة على البريد الإلكتروني للتحقق من حسابك"),
        "loading": MessageLookupByLibrary.simpleMessage("جارى التحميل"),
        "pressRetryToTryAgain": MessageLookupByLibrary.simpleMessage(
            "اضغط على إعادة المحاولة للمحاولة مرة أخرى"),
        "retry": MessageLookupByLibrary.simpleMessage("أعد المحاولة"),
        "youAreOfflinePleaseCheckYourInternetConnection":
            MessageLookupByLibrary.simpleMessage(
                "أنت غير متصل بالإنترنت ، يرجى التحقق من اتصالك بالإنترنت"),
        "noPostsFound": MessageLookupByLibrary.simpleMessage("لا يوجد منشورات"),
      };
}
