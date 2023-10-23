import 'dart:convert';

import 'package:contact_book/Controller/database.dart';
import 'package:contact_book/Controller/search_contact.dart';
import 'package:contact_book/Controller/share_pref.dart';
import 'package:contact_book/Model/Constants/key.dart';
import 'package:contact_book/View/Widgets/contact_tile.dart';
import 'package:contact_book/View/page/add_update_contact.dart';
import 'package:flutter/material.dart';

import '../../Model/Contact.dart';
import '../../Model/user.dart';
import '../Widgets/input.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static List<Contact> contacts = [];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getUserContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact book'),
        actions: [
          IconButton(
            onPressed: () {
              // remove user in shared pref.
              SharedPref.sp!
                  .setString(KeyClass.keyForLoggedUser, '')
                  .then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      drawer: Drawer(
          child: UserAccountsDrawerHeader(
              accountName: Text(user!.name!),
              accountEmail: Text(user!.email!))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUpdateContact(loggedUser: user!),
              )).then((value) => setState(() {
                // getUserContacts(); // to get data from database
              }));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Inputs(
            hint: 'Search',
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                Search.contact(value);
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchController.text.isEmpty
                  ? HomePage.contacts.length
                  : Search.searchList.length,
              itemBuilder: (context, index) {
                return ContactTile(
                  contact: _searchController.text.isEmpty
                      ? HomePage.contacts[index]
                      : Search.searchList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void getUserDetails() {
    String loggedUser =
        SharedPref.sp!.getString(KeyClass.keyForLoggedUser) ?? '{}';
    Map m = jsonDecode(loggedUser);
    user = User(
      id: m['id'],
      name: m['name'],
      email: m['email'],
      contact: m['contact'],
      password: m['password'],
    );
  }

  void getUserContacts() {
    DatabaseClass().viewContact(userid: user!.id!).then((value) {
      setState(() {
        HomePage.contacts.addAll(value);
      });
    });
  }
}
