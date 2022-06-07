import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universe/business_logic/cubit/user_login_cubit.dart';
import 'package:universe/business_logic/cubit/user_signup_cubit.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/data/repository/user_repository.dart';
import 'package:universe/data/web_services/user_web_services.dart';
import 'package:universe/presentation/screens/home_screen.dart';
import 'package:universe/presentation/screens/signup_screen.dart';
import 'package:universe/tools/translation/locale_helper.dart';
import 'package:universe/tools/translation/localizations.dart';

class LoginScreen extends StatefulWidget {
  final String language;

  const LoginScreen({Key? key, required this.language}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  late SpecificLocalizationDelegate _specificLocalizationDelegate;

  @override
  void initState() {
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(Locale(widget.language));
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _specificLocalizationDelegate = SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        const FallbackCupertinoLocalisationsDelegate(),
        _specificLocalizationDelegate
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      locale: _specificLocalizationDelegate.overriddenLocale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: MyColors.backgroundGreyColor,
          brightness: Brightness.light,
          primaryColor: MyColors.primaryColor,
          fontFamily: 'Almarai'),
      home: BlocProvider(
        create: (BuildContext context) =>
            UserLoginCubit(UserRepository(UserWebServices())),
        child: MyLoginPage(
          myLanguage: widget.language,
        ),
      ),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  final String myLanguage;

  const MyLoginPage({Key? key, required this.myLanguage}) : super(key: key);

  @override
  MyLoginPageState createState() => MyLoginPageState();
}

class MyLoginPageState extends State<MyLoginPage>
    with TickerProviderStateMixin {
  MyLoginPageState();

  late BuildContext mContext;
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool viewPassword = false;

  late Animation animationLogin;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void animateButton() {
    var controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animationLogin = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(
            AppLocalizations.of(context)!.login,
            style: TextStyle(
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: MyColors.backgroundGreyColor,
        ),
        body: Container(
          color: MyColors.backgroundGreyColor,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 16.0, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            AppLocalizations.of(context)!.userName,
                            style: TextStyle(
                                color: MyColors.textPrimaryColor.withOpacity(1),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: userNameController,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              borderSide: BorderSide(
                                color: MyColors.inputBackgroundColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            filled: true,
                            fillColor:
                                MyColors.inputBackgroundColor.withOpacity(0.2),
                          ),
                          validator: (String? valueUserName) {
                            if (valueUserName!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourUserName;
                            } else {
                              return null;
                            }
                          },
                          cursorColor: MyColors.accentColor,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: MyColors.textPrimaryColor,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            AppLocalizations.of(context)!.password,
                            style: TextStyle(
                                color: MyColors.textPrimaryColor.withOpacity(1),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordController,
                          textCapitalization: TextCapitalization.none,
                          obscureText: viewPassword ? false : true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              borderSide: BorderSide(
                                color: MyColors.inputBackgroundColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            filled: true,
                            fillColor:
                                MyColors.inputBackgroundColor.withOpacity(0.2),
                            suffixIcon: IconButton(
                              icon: viewPassword
                                  ? Image.asset(
                                      'assets/images/showpassword.png',
                                      height: 30.0,
                                      width: 30.0,
                                      color: MyColors.textPrimaryLightColor
                                          .withOpacity(0.6),
                                    )
                                  : Image.asset(
                                      'assets/images/hidepassword.png',
                                      height: 30.0,
                                      width: 30.0,
                                      color: MyColors.textPrimaryLightColor
                                          .withOpacity(0.6),
                                    ),
                              onPressed: () {
                                if (viewPassword) {
                                  setState(() {
                                    viewPassword = false;
                                  });
                                } else {
                                  setState(() {
                                    viewPassword = true;
                                  });
                                }
                              },
                            ),
                          ),
                          validator: (String? valuePassword) {
                            if (valuePassword!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseEnterYourPassword;
                            } else {
                              return null;
                            }
                          },
                          cursorColor: MyColors.accentColor,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: MyColors.textPrimaryColor,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {},
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .forgotPasswordWithQuestionMark,
                              style: TextStyle(
                                  color: MyColors.primaryColor.withOpacity(1),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 0, left: 20.0, right: 20.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    animateButton();
                                    await BlocProvider.of<UserLoginCubit>(
                                            context)
                                        .login(userNameController.text.trim(),
                                            passwordController.text.trim())
                                        .then((loginResponse) {
                                      if (loginResponse == "success") {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(
                                                        languageHome:
                                                            widget.myLanguage)),
                                            ModalRoute.withName("/Home"));
                                      } else if (loginResponse ==
                                          "notVerified") {
                                        Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .accountNotVerifiedPleaseFollowInstructionsOnEmailToVerifyYourAccount,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                      } else if (loginResponse ==
                                          "user-not-found") {
                                        Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .userNameDoesNotFound,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                      } else if (loginResponse ==
                                          "wrong-password") {
                                        Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .passwordIsNotCorrect,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!
                                                .emailOrPasswordIsNotCorrect,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                      }
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColors.accentColor,
                                  ),
                                ),
                                child: buildLoginButton(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: MyColors.textPrimaryLightColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            AppLocalizations.of(context)!.or,
                            style: TextStyle(
                                color: MyColors.textPrimaryColor.withOpacity(1),
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: MyColors.textPrimaryLightColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16, left: 16.0, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            AppLocalizations.of(context)!
                                .ifYouDoNotHaveAnAccountSignUp,
                            style: TextStyle(
                                color: MyColors.textPrimaryColor.withOpacity(1),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 15.0, left: 20.0, right: 20.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (BuildContext context) =>
                                          UserSignupCubit(UserRepository(
                                              UserWebServices())),
                                      child: SignupScreen(
                                          myLanguage: widget.myLanguage),
                                    ),
                                  ));
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: MyColors.accentColor,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColors.backgroundGreyColor,
                                  ),
                                ),
                                child: buildCreateAccountButton(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          AppLocalizations.of(mContext)!.areYouSureOfExit,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Text(
              AppLocalizations.of(mContext)!.yes,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(mContext)!.no,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
    ).then((value) => value ?? false);
  }

  Widget buildLoginButton() {
    return BlocBuilder<UserLoginCubit, UserLoginState>(
      builder: (context, state) {
        if (state is UserLoginLoading) {
          return const SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ));
        } else {
          return Text(
            AppLocalizations.of(context)!.login,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          );
        }
      },
    );
  }

  Widget buildCreateAccountButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/adduser.png',
          height: 25.0,
          width: 25.0,
          color: MyColors.accentColor.withOpacity(1),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          AppLocalizations.of(context)!.createNewAccount,
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: MyColors.accentColor),
        ),
      ],
    );
  }
}
