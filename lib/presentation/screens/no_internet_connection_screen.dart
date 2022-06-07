import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/tools/tools.dart';
import 'package:universe/tools/translation/localizations.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  @override
  NoInternetConnectionScreenState createState() =>
      NoInternetConnectionScreenState();
}

class NoInternetConnectionScreenState
    extends State<NoInternetConnectionScreen> {
  NoInternetConnectionScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: SizedBox(
          width: 40,
          height: 40,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyColors.primaryDarkColor,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/internet.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                  ),
                  Text(
                    AppLocalizations.of(context)!.errorConnectingToTheInternet,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Text(
                    AppLocalizations.of(context)!.pressRetryToTryAgain,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 20.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              MyColors.primaryDarkColor,
                            ),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10)),
                          ),
                          onPressed: () async {
                            await Tools.checkInternetConnection()
                                .then((responseNetwork) {
                              if (responseNetwork == '1') {
                                Navigator.of(context).pop();
                              } else {
                                Fluttertoast.showToast(
                                    msg: AppLocalizations.of(context)!
                                        .youAreOfflinePleaseCheckYourInternetConnection,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
                              }
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context)!.retry,
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
