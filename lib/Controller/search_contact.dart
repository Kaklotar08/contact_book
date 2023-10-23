import 'package:contact_book/View/page/home.dart';

import '../Model/Contact.dart';

class Search {
  static List<Contact> searchList = [];

  static void contact(String value) {
    searchList = HomePage.contacts
        .where(
          (contact) => contact.name == value || contact.contact == value,
        )
        .toList();
  }
}
