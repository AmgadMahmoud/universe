import 'package:flutter/material.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/presentation/screens/home_screen.dart';
import 'package:universe/presentation/screens/login_screen.dart';
import 'package:universe/tools/tools.dart';
import 'package:universe/tools/translation/locale_helper.dart';

class LanguageItemWidget extends StatelessWidget {
  final String language;
  final BuildContext parentContext;
  final bool isChange;

  const LanguageItemWidget({
    Key? key,
    required this.language,
    required this.parentContext,
    required this.isChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      child: SizedBox(
        width: double.infinity,
        height: 50.0,
        child: TextButton(
          onPressed: () async {
            if (isChange) {
              helper.onLocaleChanged(Locale(language));
              await Tools.saveLanguageInShared(language).then((value) async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              languageHome: language,
                            )),
                    ModalRoute.withName("/home"));
              });
            } else {
              helper.onLocaleChanged(Locale(language));
              await Tools.saveLanguageInShared(language).then((value) async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(
                              language: language,
                            )),
                    ModalRoute.withName("/home"));
              });
            }
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              language == "en"
                  ? MyColors.primaryDarkColor
                  : MyColors.accentColor,
            ),
          ),
          child: Text(
            language == "en" ? "English" : "العربية",
            style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
