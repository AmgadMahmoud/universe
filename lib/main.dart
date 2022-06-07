import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/presentation/screens/choose_language_screen.dart';
import 'package:universe/presentation/screens/home_screen.dart';
import 'package:universe/presentation/screens/login_screen.dart';

import 'authService.dart';

typedef LocaleChangeCallback = void Function(Locale locale);

AuthService appAuth = AuthService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String myLanguage = prefs.getString('language') ?? "";

  Widget defaultHome = const ChooseLanguageScreen();
  if (myLanguage.isNotEmpty) {
    bool result = await appAuth.login();
    if (result) {
      defaultHome = HomeScreen(
        languageHome: myLanguage,
      );
    } else {
      defaultHome = LoginScreen(
        language: myLanguage,
      );
    }
  } else {
    defaultHome = const ChooseLanguageScreen();
    myLanguage = "en";
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    builder: (BuildContext context, Widget? child) {
      return Builder(
        builder: (BuildContext context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1.0, alwaysUse24HourFormat: false),
            child: child!,
          );
        },
      );
    },
    theme: ThemeData(
      backgroundColor: MyColors.backgroundGreyColor,
      textTheme: const TextTheme(
        headline5: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          fontSize: 14.0,
        ),
      ),
    ),
    title: "Universe",
    home: defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => HomeScreen(
            languageHome: myLanguage,
          ),
      '/language': (BuildContext context) => const ChooseLanguageScreen(),
      '/login': (BuildContext context) => LoginScreen(
            language: myLanguage,
          )
    },
  ));
}
