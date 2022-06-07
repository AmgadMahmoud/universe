import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universe/business_logic/cubit/user_signup_cubit.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/data/models/user.dart';
import 'package:universe/tools/translation/localizations.dart';

class SignupScreen extends StatefulWidget {
  final String myLanguage;

  const SignupScreen({Key? key, required this.myLanguage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  SignupScreenState();

  late BuildContext mContext;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool viewPassword = false;
  bool viewConfirmPassword = false;

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

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text(
          AppLocalizations.of(context)!.signUp,
          style: TextStyle(
              color: MyColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        leading: BackButton(
          color: MyColors.navigationColor,
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
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 16.0, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)!.email,
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
                    controller: emailController,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: MyColors.inputBackgroundColor.withOpacity(0.2),
                        ),
                      ),
                      filled: true,
                      fillColor: MyColors.inputBackgroundColor.withOpacity(0.2),
                    ),
                    validator: (String? valueEmail) {
                      if (valueEmail!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterYourEmail;
                      } else {
                        return null;
                      }
                    },
                    cursorColor: MyColors.accentColor,
                    keyboardType: TextInputType.emailAddress,
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
                          color: MyColors.inputBackgroundColor.withOpacity(0.2),
                        ),
                      ),
                      filled: true,
                      fillColor: MyColors.inputBackgroundColor.withOpacity(0.2),
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
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)!.confirmPassword,
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
                    controller: confirmPasswordController,
                    textCapitalization: TextCapitalization.none,
                    obscureText: viewConfirmPassword ? false : true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: MyColors.inputBackgroundColor.withOpacity(0.2),
                        ),
                      ),
                      filled: true,
                      fillColor: MyColors.inputBackgroundColor.withOpacity(0.2),
                      suffixIcon: IconButton(
                        icon: viewConfirmPassword
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
                          if (viewConfirmPassword) {
                            setState(() {
                              viewConfirmPassword = false;
                            });
                          } else {
                            setState(() {
                              viewConfirmPassword = true;
                            });
                          }
                        },
                      ),
                    ),
                    validator: (String? valueConfirmPassword) {
                      if (valueConfirmPassword!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseConfirmYourPassword;
                      } else if (valueConfirmPassword !=
                          passwordController.text) {
                        return AppLocalizations.of(context)!
                            .passwordDoesNotMatch;
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
                      AppLocalizations.of(context)!.firstName,
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
                    controller: firstNameController,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: MyColors.inputBackgroundColor.withOpacity(0.2),
                        ),
                      ),
                      filled: true,
                      fillColor: MyColors.inputBackgroundColor.withOpacity(0.2),
                    ),
                    validator: (String? valueFirstName) {
                      if (valueFirstName!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterYourFirstName;
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
                      AppLocalizations.of(context)!.lastName,
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
                    controller: lastNameController,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide(
                          color: MyColors.inputBackgroundColor.withOpacity(0.2),
                        ),
                      ),
                      filled: true,
                      fillColor: MyColors.inputBackgroundColor.withOpacity(0.2),
                    ),
                    validator: (String? valueLastName) {
                      if (valueLastName!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterYourLastName;
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
                              await BlocProvider.of<UserSignupCubit>(context)
                                  .signup(
                                      UserData(
                                          firstName:
                                              firstNameController.text.trim(),
                                          lastName:
                                              lastNameController.text.trim(),
                                          email: emailController.text.trim(),
                                          userName:
                                              "${firstNameController.text.trim()} ${lastNameController.text.trim()}"),
                                      passwordController.text.trim())
                                  .then((signupResponse) {
                                if (signupResponse == "success") {
                                  Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .accountCreatedSuccessfullyAnEmailHasBeenSentToVerifyYourAccount,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                  Navigator.of(context).pop();
                                } else if (signupResponse == "weak-password") {
                                  Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .thePasswordProvidedIsTooWeak,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                } else if (signupResponse ==
                                    "email-already-in-use") {
                                  Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .theAccountAlreadyExistsForThatEmail,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                } else if (signupResponse == "error") {
                                  Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .errorConnectingWithServer,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .invalidCredentials,
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                              MyColors.accentColor,
                            ),
                          ),
                          child: buildSignupButton(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignupButton() {
    return BlocBuilder<UserSignupCubit, UserSignupState>(
      builder: (context, state) {
        if (state is UserSignupLoading) {
          return const SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ));
        } else {
          return Text(
            AppLocalizations.of(context)!.signUp,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          );
        }
      },
    );
  }
}
