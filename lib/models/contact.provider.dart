import 'package:flutter/material.dart';
import 'contactdata.dart'; // Importa tu clase Contact

class ContactProvider extends ChangeNotifier {
  final List<ContactData> _contacts = [];

  List<ContactData> get contacts => _contacts;

  void addContact(ContactData contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void updateContact(ContactData updatedContact) {
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
   void updateLabels(int contactId, List<String> newLabels) {
    int index = _contacts.indexWhere((contact) => contact.id == contactId);
    if (index != -1) {
      _contacts[index].labels = newLabels;
      notifyListeners();
    }
  }
}
