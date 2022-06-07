import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universe/business_logic/cubit/all_posts_cubit.dart';
import 'package:universe/constants/my_colors.dart';
import 'package:universe/presentation/screens/no_internet_connection_screen.dart';
import 'package:universe/presentation/widgets/add_post_dialog.dart';
import 'package:universe/presentation/widgets/jumping_dots_widget.dart';
import 'package:universe/tools/tools.dart';
import 'package:universe/tools/translation/localizations.dart';

class HomeFragmentScreen extends StatefulWidget {
  const HomeFragmentScreen({Key? key}) : super(key: key);

  @override
  HomeFragmentScreenState createState() => HomeFragmentScreenState();
}

class HomeFragmentScreenState extends State<HomeFragmentScreen> {
  HomeFragmentScreenState();

  late BuildContext pageContext;
  String myLanguage = "";

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getSharedData();
  }

  void getSharedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myLanguage = prefs.getString("language") ?? "en";
    });
    await Tools.checkInternetConnection().then((connectionResponse) async {
      if (connectionResponse == '1') {
        await BlocProvider.of<AllPostsCubit>(context).getAllPosts();
      } else {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                const NoInternetConnectionScreen(),
          ),
        )
            .then((value) async {
          await Tools.checkInternetConnection().then((value) async {
            if (connectionResponse == '1') {
              await BlocProvider.of<AllPostsCubit>(context).getAllPosts();
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageContext = context;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: "add",
        backgroundColor: MyColors.accentColor,
        onPressed: () async {
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AppPostDialog(
              pageContext: pageContext,
              myLanguage: myLanguage,
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: MyColors.whiteColor,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: MyColors.backgroundGreyColor,
        child: buildPageBody(),
      ),
    );
  }

  Widget buildPageBody() {
    return BlocBuilder<AllPostsCubit, AllPostsState>(
      builder: (context, state) {
        if (state is AllPostsLoading) {
          return showLoadingPosts();
        } else if (state is AllPostsLoaded) {
          return buildLoadedPostsList((state).posts);
        } else if (state is AllPostsEmpty) {
          return buildEmptyPostsWidget();
        } else {
          return showLoadingPosts();
        }
      },
    );
  }

  Widget showLoadingPosts() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const JumpingDots(),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.loading,
              style: TextStyle(
                fontSize: 14.0,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyPostsWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.noPostsFound,
              style: TextStyle(
                fontSize: 14.0,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoadedPostsList(List<Map> posts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: MyColors.inputBackgroundColor
                                  .withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('assets/images/user.png',
                                  color: MyColors.drawerColor,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset('assets/images/share.png',
                                  color: MyColors.inputBackgroundColor,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover),
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset('assets/images/bookmark.png',
                                  color: MyColors.inputBackgroundColor,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover),
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset('assets/images/like.png',
                                  color: MyColors.inputBackgroundColor,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.asset(
                        'assets/images/postdefaultimage.png',
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      posts[index]["description"],
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onRefresh() async {
    getSharedData();
    _refreshController.refreshCompleted();
  }
}
