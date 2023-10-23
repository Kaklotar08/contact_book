import 'package:contact_book/Model/user.dart';
import 'package:contact_book/View/Widgets/input.dart';
import 'package:flutter/material.dart';

import '../../Controller/database.dart';
import '../Widgets/botton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 80),
          const Center(child: Text('Register Page')),
          const SizedBox(height: 50),
          Inputs(
            controller: _nameController,
            hint: 'Name',
            themeColor: Colors.amber,
          ),
          const SizedBox(height: 50),
          Inputs(
            controller: _emailController,
            hint: 'Email',
          ),
          const SizedBox(height: 50),
          Inputs(
            controller: _passwordController,
            hint: 'Password',
          ),
          const SizedBox(height: 50),
          Inputs(
            controller: _contactController,
            hint: 'Contact',
          ),
          const SizedBox(height: 50),
          CustomButton(
            title: 'Login',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 50),
          CustomButton(
            title: 'Register',
            onTap: () {
              var user = User(
                name: getText(_nameController),
                email: _emailController.text,
                password: _passwordController.text,
                contact: _contactController.text,
              );
              // check user is exist?
              DatabaseClass.verifyUser(user).then((verify) {
                if (verify) {
                  // register user in database
                  DatabaseClass.registerUser(user).then((value) {
                    Navigator.pop(context);
                  });
                }
              });
            },
          ),
        ],
      ),
    );
  }

  String getText(TextEditingController controller) => controller.text;
}
