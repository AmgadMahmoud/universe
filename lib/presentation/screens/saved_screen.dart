import 'package:flutter/material.dart';
import 'package:universe/constants/my_colors.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  SavedScreenState createState() => SavedScreenState();
}

class SavedScreenState extends State<SavedScreen> {
  SavedScreenState();

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
              Text(
                "Saved",
                style: TextStyle(
                  fontSize: 16.0,
                  color: MyColors.textPrimaryColor,
                  fontWeight: FontWeight.normal,
                ),
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
