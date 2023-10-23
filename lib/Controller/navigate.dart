import 'package:contact_book/Controller/share_pref.dart';
import 'package:contact_book/View/page/home.dart';
import 'package:contact_book/View/page/login.dart';
import 'package:flutter/material.dart';

class Navigate {
  static void navigate({
    required BuildContext context,
  }) {
    SharedPref.isLoggedIn().then((loginStatus) {
      if (loginStatus == LoginStatus.login) {
        // homepage
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      } else {
        // loginPage
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      }
    });
  }
}
