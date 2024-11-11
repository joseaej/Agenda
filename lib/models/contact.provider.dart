import 'package:flutter/material.dart';
import 'contactdata.dart'; // Importa tu clase Contact

class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void updateContact(Contact updatedContact) {
    int index = _contacts.indexWhere((contact) => contact.id == updatedContact.id);
    if (index != -1) {
      _contacts[index] = updatedContact;
      notifyListeners();
    }
  }

  void removeContact(int id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }
}
