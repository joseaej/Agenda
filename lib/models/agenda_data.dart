import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contactdata.dart';

enum AgendaStatus { Initial, Loading, Ready, Error }
class AgendaData extends ChangeNotifier {
  
  List<ContactData> contacts;
  AgendaStatus _status = AgendaStatus.Initial;
  AgendaStatus get status => _status;

  AgendaData({List<ContactData>? contacts}) : contacts = contacts ?? [];

  factory AgendaData.fromJson(Map<String, dynamic> json) {
    var contactsJson = json['contacts'] as List<dynamic>;

    List<ContactData> contactList = contactsJson
        .map((contactJson) => ContactData.fromJson(contactJson))
        .toList();

    return AgendaData(contacts: contactList);
  }
  void _setStatus(AgendaStatus newStatus) {
    _status = newStatus;
    notifyListeners();
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
    Future<void> save() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final agendaJson = jsonEncode(toJson());

      await prefs.setString('agenda_data', agendaJson);
    } catch (e) {
      debugPrint('Error guardando la agenda: $e');
    }
  }

  Future<void> load() async {
    _setStatus(AgendaStatus.Loading);

    try {
      await Future.delayed(const Duration(seconds: 2)); 

      final prefs = await SharedPreferences.getInstance();

      final agendaJson = prefs.getString('agenda_data');

      if (agendaJson != null) {
        final decodedJson = jsonDecode(agendaJson);
        final loadedAgenda = AgendaData.fromJson(decodedJson);

        contacts = loadedAgenda.contacts;

        _setStatus(AgendaStatus.Ready);
      } else {
        _setStatus(AgendaStatus.Initial);
      }
    } catch (e) {
      _setStatus(AgendaStatus.Error);
      debugPrint('Error cargando la agenda: $e');
    }
  }
}

