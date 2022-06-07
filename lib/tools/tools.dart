import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tools {

  static saveLanguageInShared(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", language);
  }

  static Future<String> checkInternetConnection() async {
    String connectionResult;
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      connectionResult = "0";
    } else {
      connectionResult = "1";
    }
    return connectionResult;
  }
}