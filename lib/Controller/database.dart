import 'package:contact_book/Model/Contact.dart';
import 'package:contact_book/Model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'navigate.dart';

class DatabaseClass {
  static Database? database;

  static void createDatabase({required BuildContext context}) async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

// open the database
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT, contact TEXT)');
      await db.execute(
          'CREATE TABLE Contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT, userId TEXT)');
    });
    // after create database
    Navigate.navigate(context: context);
  }

  // method for register user
  static Future<void> registerUser(User user) async {
    String sql =
        "INSERT INTO Users (name, email, password, contact) VALUES('${user.name}', '${user.email}', '${user.password}', '${user.contact}')";
    int result = await database!.rawInsert(sql);
  }

  // method for login
  static Future<bool> verifyUser(User user) async {
    String sql =
        "SELECT * FROM Users WHERE email = '${user.email}' OR contact = '${user.contact}'";
    List<Map<String, Object?>> users = await database!.rawQuery(sql);
    return users.isEmpty;
  }

  static Future<List<Map<String, Object?>>> verifyLogin(User user) async {
    String sql =
        "SELECT * FROM Users WHERE email = '${user.email}' AND password = '${user.password}'";
    List<Map<String, Object?>> users = await database!.rawQuery(sql);
    return users;
  }

  static Future<void> addContact(Contact contact) async {
    String sql =
        "INSERT INTO Contacts (name, contact, userId) VALUES('${contact.name}', '${contact.contact}', '${contact.userId}')";
    await database!.rawInsert(sql);
  }

  void updateContact() {}

  void deleteContact() {}

  Future<Iterable<Contact>> viewContact({required String userid}) async {
    String sql = "SELECT * FROM Contacts WHERE userId = '$userid'";
    List<Map<String, Object?>> contacts = await database!.rawQuery(sql);
    return contacts.map((con) {
      Contact contact = Contact(
        userId: con['userId'].toString(),
        name: con['name'].toString(),
        contact: con['contact'].toString(),
      );
      return contact;
    });
  }
}
