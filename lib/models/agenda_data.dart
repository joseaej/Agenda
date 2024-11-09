import 'package:flutter/material.dart';

import 'contactdata.dart';

class AgendaData extends ChangeNotifier {
  List<Contact> contacts;

  AgendaData({List<Contact>? contacts}) : contacts = contacts ?? [];

  factory AgendaData.fromJson(Map<String, dynamic> json) {
    var contactsJson = json['contacts'] as List<dynamic>;

    List<Contact> contactList = contactsJson
        .map((contactJson) => Contact.fromJson(contactJson))
        .toList();

    return AgendaData(contacts: contactList);
  }

  Map<String, dynamic> toJson() {
    return {
      'contacts': contacts.map((contact) => contact.toJson()).toList(),
    };
  }

  void eliminar(Contact contact) {
    contacts.remove(contact);
    notifyListeners();
  }

  void anadir(Contact contact) {
    contacts.add(contact);
    notifyListeners();
  }

  void notificar() {
    notifyListeners();
  }
}
