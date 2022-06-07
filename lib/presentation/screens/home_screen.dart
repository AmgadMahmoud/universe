import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universe/business_logic/cubit/all_posts_cubit.dart';
import 'package:universe/business_logic/cubit/user_logout_cubit.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/data/repository/home_repository.dart';
import 'package:universe/data/repository/user_repository.dart';
import 'package:universe/data/web_services/home_web_services.dart';
import 'package:universe/data/web_services/user_web_services.dart';
import 'package:universe/presentation/screens/change_language_screen.dart';
import 'package:universe/presentation/screens/home_fragment_screen.dart';
import 'package:universe/presentation/screens/login_screen.dart';
import 'package:universe/presentation/screens/my_account_fragment_screen.dart';
import 'package:universe/presentation/screens/saved_screen.dart';
import 'package:universe/tools/translation/locale_helper.dart';
import 'package:universe/tools/translation/localizations.dart';

class HomeScreen extends StatefulWidget {
  final String languageHome;

  const HomeScreen({
    Key? key,
    required this.languageHome,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenState();

  late SpecificLocalizationDelegate _specificLocalizationDelegate;

  @override
  void initState() {
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(Locale(widget.languageHome));
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
        fontFamily: 'Almarai',
        brightness: Brightness.light,
        primaryColor: MyColors.primaryColor,
      ),
      home: BlocProvider(
          create: (BuildContext context) =>
              UserLogoutCubit(UserRepository(UserWebServices())),
          child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  MyHomePageState();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late BuildContext homeContext;
  String myLanguage = "";
  TextEditingController userNameController = TextEditingController();
  String pageTitle = "";
  String currentFragment = "home";
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    userNameController.text = "";
    getSharedData();
  }

  void getSharedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myLanguage = prefs.getString("language") ?? "en";
      pageTitle = AppLocalizations.of(context)!.home;
    });

    FirebaseFirestore.instance
        .collection("users")
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          userNameController.text = element.data()["userName"];
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homeContext = context;

    return WillPopScope(
      onWillPop: onWillPop,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: buildDrawer(),
          appBar: AppBar(
            title: Text(
              pageTitle,
              style: TextStyle(
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            backgroundColor: MyColors.primaryDarkColor,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            bottom: currentFragment == "home" || currentFragment == "myAccount"
                ? TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: MyColors.whiteColor,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.normal,
                    ),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.home,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.myAccount,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : null,
          ),
          body: currentFragment == "home" || currentFragment == "myAccount"
              ? TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BlocProvider(
                        create: (BuildContext context) =>
                            AllPostsCubit(HomeRepository(HomeWebServices())),
                        child: const HomeFragmentScreen()),
                    const MyAccountFragmentScreen(),
                  ],
                )
              : const SavedScreen(),
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: MyColors.drawerColor,
            width: double.infinity,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: MyColors.inputBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/images/user.png',
                            color: MyColors.backgroundGreyColor,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: Text(
                        userNameController.text,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.home,
              style: TextStyle(
                fontSize: 18.0,
                color: MyColors.drawerColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            leading: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image(
                image: const ExactAssetImage('assets/images/home.png'),
                color: MyColors.drawerColor,
              ),
            ),
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
              setState(() {
                currentFragment = "home";
                pageTitle = AppLocalizations.of(context)!.home;
                _tabController.animateTo(0);
              });
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.myAccount,
              style: TextStyle(
                fontSize: 18.0,
                color: MyColors.drawerColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            leading: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image(
                image: const ExactAssetImage('assets/images/user.png'),
                color: MyColors.drawerColor,
              ),
            ),
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
              setState(() {
                currentFragment = "myAccount";
                pageTitle = AppLocalizations.of(context)!.myAccount;
                _tabController.animateTo(1);
              });
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.saved,
              style: TextStyle(
                fontSize: 18.0,
                color: MyColors.drawerColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            leading: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image(
                image: const ExactAssetImage('assets/images/saved.png'),
                color: MyColors.drawerColor,
              ),
            ),
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
              setState(() {
                currentFragment = "saved";
                pageTitle = AppLocalizations.of(context)!.saved;
              });
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.changeLanguage,
              style: TextStyle(
                fontSize: 18.0,
                color: MyColors.drawerColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            leading: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image(
                image: const ExactAssetImage('assets/images/translate.png'),
                color: MyColors.drawerColor,
              ),
            ),
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const ChangeLanguageScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.logout,
              style: TextStyle(
                fontSize: 18.0,
                color: MyColors.drawerColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            leading: SizedBox(
              width: 20.0,
              height: 20.0,
              child: Image(
                image: const ExactAssetImage('assets/images/logout.png'),
                color: MyColors.drawerColor,
              ),
            ),
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            color: MyColors.accentColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                                AppLocalizations.of(homeContext)!.pleaseWait),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
              await BlocProvider.of<UserLogoutCubit>(context)
                  .logout()
                  .then((logoutResponse) async {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pushAndRemoveUntil(
                    homeContext,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen(language: myLanguage)),
                    ModalRoute.withName("/Login"));
              });
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.appVersion,
              style: TextStyle(
                fontSize: 12.0,
                color: MyColors.drawerColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> onWillPop() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      setState(() {
        Navigator.pop(context);
      });
      return Future.value(false);
    } else {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            AppLocalizations.of(homeContext)!.areYouSureOfExit,
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
                AppLocalizations.of(homeContext)!.yes,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocalizations.of(homeContext)!.no,
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
  }
}
