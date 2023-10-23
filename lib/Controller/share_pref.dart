import 'package:contact_book/Model/Constants/key.dart';
import 'package:contact_book/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginStatus { login, logout }

class SharedPref {
  static SharedPreferences? sp;

  static Future<LoginStatus> isLoggedIn() async {
    sp = await SharedPreferences.getInstance();
    String isLogin = sp!.getString(KeyClass.keyForLoggedUser) ?? '';
    if (isLogin.isNotEmpty) {
      return LoginStatus.login;
    } else {
      return LoginStatus.logout;
    }
  }

  static Future<bool> saveUser(User user) async {
    return await sp!.setString(
      KeyClass.keyForLoggedUser,
      user.toString(),
    );
  }
}
