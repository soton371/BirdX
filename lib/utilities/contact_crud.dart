import 'dart:io';
import 'package:birdx/database/database_helper.dart';
import 'package:birdx/models/contact.dart';

Future<List<Contact>> getContacts() async {
  List<Contact> contactList = await DatabaseHelper.instance.getContacts();
  return contactList;
}

Future<int> addContact(
    {required String name,
    required String number}) async {
  
  Contact newContact = Contact(
    name: name,
    number: number,
  );
  int result = await DatabaseHelper.instance.insertContact(newContact);
  return result;
}

Future<int> updateContact(
    {required Contact contact,
    required String newName,
    required String newNumber,
    required File newImage}) async {
  Contact updatedContact = Contact(
    id: contact.id,
    name: newName.isNotEmpty ? newName : contact.name,
    number: newNumber.isNotEmpty ? newNumber : contact.number,
  );
  int result = await DatabaseHelper.instance.updateContact(updatedContact);

  return result;
}

Future<int> deleteContact(Contact contact) async {
  int result = await DatabaseHelper.instance.deleteContact(contact.id!);
  return result;
}
