import 'package:contact_book/Controller/database.dart';
import 'package:contact_book/Model/Contact.dart';
import 'package:contact_book/Model/user.dart';
import 'package:contact_book/View/page/home.dart';
import 'package:flutter/material.dart';

import '../Widgets/botton.dart';
import '../Widgets/input.dart';

class AddUpdateContact extends StatefulWidget {
  final User loggedUser;

  const AddUpdateContact({super.key, required this.loggedUser});

  @override
  State<AddUpdateContact> createState() => _AddUpdateContactState();
}

class _AddUpdateContactState extends State<AddUpdateContact> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 80),
          const Center(child: Text('Add Contact')),
          const SizedBox(height: 50),
          Inputs(
            controller: _nameController,
            hint: 'Name',
            themeColor: Colors.amber,
          ),
          const SizedBox(height: 50),
          Inputs(
            controller: _contactController,
            hint: 'Contact',
          ),
          const SizedBox(height: 50),
          CustomButton(
            title: 'Save',
            onTap: () {
              // add contact in database
              Contact contact = Contact(
                userId: widget.loggedUser.id!,
                name: _nameController.text,
                contact: _contactController.text,
              );
              // HomePage.contacts.add(contact);
              // to add contact in list without database
              DatabaseClass.addContact(contact).then((value) {
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
