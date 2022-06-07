import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/presentation/widgets/language_item_widget.dart';
import 'package:universe/tools/translation/localizations.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  ChangeLanguageScreenState createState() => ChangeLanguageScreenState();
}

class ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  ChangeLanguageScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            AppLocalizations.of(context)!.changeLanguage,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: MyColors.primaryDarkColor,
      ),
      body: Container(
        alignment: Alignment.center,
        color: MyColors.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 16,
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
                isChange: true,
              ),
              LanguageItemWidget(
                language: "ar",
                parentContext: context,
                isChange: true,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
