import 'package:flutter/material.dart';

import 'contactdata.dart';

class AgendaData extends ChangeNotifier {
  List<ContactData> contacts;

  AgendaData({List<ContactData>? contacts}) : contacts = contacts ?? [];

  factory AgendaData.fromJson(Map<String, dynamic> json) {
    var contactsJson = json['contacts'] as List<dynamic>;

    List<ContactData> contactList = contactsJson
        .map((contactJson) => ContactData.fromJson(contactJson))
        .toList();

    return AgendaData(contacts: contactList);
  }

  Map<String, dynamic> toJson() {
    return {
      'contacts': contacts.map((contact) => contact.toJson()).toList(),
    };
  }

  void eliminar(ContactData contact) {
    contacts.remove(contact);
    notifyListeners();
  }

  void anadir(ContactData contact) {
    contacts.add(contact);
    notifyListeners();
  }

  void notificar() {
    notifyListeners();
  }
}
