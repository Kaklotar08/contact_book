import 'package:contact_book/Controller/database.dart';
import 'package:contact_book/Controller/share_pref.dart';
import 'package:contact_book/Model/user.dart';
import 'package:contact_book/View/Widgets/botton.dart';
import 'package:contact_book/View/Widgets/input.dart';
import 'package:contact_book/View/page/home.dart';
import 'package:contact_book/View/page/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 80),
          const Center(child: Text('Login Page')),
          const SizedBox(height: 50),
          Inputs(
            controller: _emailController,
            hint: 'Email',
            themeColor: Colors.amber,
          ),
          const SizedBox(height: 50),
          Inputs(
            controller: _passwordController,
            hint: 'Password',
          ),
          const SizedBox(height: 50),
          CustomButton(
            title: 'Login',
            onTap: () {
              print('log: login clicked');
              var user = User(
                email: _emailController.text,
                password: _passwordController.text,
              );
              DatabaseClass.verifyLogin(user).then((value) {
                if (value.isNotEmpty) {
                  print('log: user found');
                  user = User(
                    id: value[0]['id'].toString(),
                    name: value[0]['name'].toString(),
                    email: value[0]['email'].toString(),
                    contact: value[0]['contact'].toString(),
                    password: value[0]['password'].toString(),
                  );
                  // save userdata in shared pref.
                  SharedPref.saveUser(user).then((value) {
                    if (value) {
                      // homepage
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    } else {
                      // error
                    }
                  });
                }
              });
            },
          ),
          const SizedBox(height: 50),
          CustomButton(
            title: 'Register',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
