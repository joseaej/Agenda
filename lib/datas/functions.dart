import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:agenda/pages/contactFormPage.dart';
import 'package:flutter/material.dart';
import 'package:agenda/datas/messages.dart';
import 'package:provider/provider.dart';
// String? validarEmail(String? value) {
//   String? error;
//   if (value != null) {
//     if (value.isNotEmpty &&
//         value.contains(RegExpMatch.(
//             r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {}
//   }
// }

void onCreateContact(BuildContext context) async {
  Contact contacto = Contact(
      id: 0,
      birthdate: null,
      creation: null,
      email: null,
      name: null,
      phone: null,
      surname: null);
  await Navigator.of(context)
      .push(MaterialPageRoute(
          builder: (context) => ContactFormPage(contacto: contacto)))
      .then(
    (value) {
      if (value != null) {
        contacto.creation = DateTime.now();
        agenda.anadir(contacto);
      }
    },
  );
}

void onEditContact(BuildContext context, Contact contact) async {
  Contact newContact = contact.copyWith();
  await Navigator.of(context)
      .push(MaterialPageRoute(
    builder: (context) => ContactFormPage(contacto: newContact),
  ))
      .then(
    (value) {
      if (value != null) {
        contact.copyValuesFrom(newContact);
        contact.modification = DateTime.now();
        Provider.of<AgendaData>(context, listen: false).notificar();
      }
    },
  );
}
