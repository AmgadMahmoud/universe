import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/presentation/widgets/language_item_widget.dart';
import 'package:universe/tools/translation/locale_helper.dart';
import 'package:universe/tools/translation/localizations.dart';

typedef LocaleChangeCallback = void Function(Locale locale);

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  ChooseLanguageScreenState createState() => ChooseLanguageScreenState();
}

class ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  ChooseLanguageScreenState();

  late SpecificLocalizationDelegate _specificLocalizationDelegate;

  @override
  void initState() {
    super.initState();

    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(const Locale("en"));
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _specificLocalizationDelegate = SpecificLocalizationDelegate(locale);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  late BuildContext mContext;

  @override
  Widget build(BuildContext context) {
    mContext = context;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MyColors.primaryDarkColor,
    ));
    return MaterialApp(
      localizationsDelegates: [
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
      home: Container(
        alignment: Alignment.center,
        color: MyColors.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 150.0,
                width: 150.0,
              ),
              const SizedBox(
                height: 20,
              ),
              LanguageItemWidget(
                language: "en",
                parentContext: context,
                isChange: false,
              ),
              LanguageItemWidget(
                language: "ar",
                parentContext: context,
                isChange: false,
              ),
              const SizedBox(
                height: 40,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
