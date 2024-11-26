import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:agenda/pages/contactFormPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsHub extends ChangeNotifier {
  String error = "";
  bool isError = false;

  Future<void> onEditContact(BuildContext context, ContactData contact,
      {bool isNew = false}) async {
    try {
      ContactData newContact = contact.copyWith();
      final result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ContactFormPage(contacto: newContact),
      ));
      if (result != null) {
        contact.copyValuesFrom(newContact);
        contact.modification = DateTime.now();

        final agendaData = Provider.of<AgendaData>(context, listen: false);
        if (isNew) {
          agendaData.contacts.add(newContact);
        }
        await agendaData.save();
        agendaData.notificar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(isNew
                  ? "Contacto creado con éxito"
                  : "Contacto editado con éxito")),
        );
      } else {
        isError = true;
        error = "Error en la modificación del contacto";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    } catch (e) {
      isError = true;
      error = "Ocurrió un error: $e";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  void onCreateContact(BuildContext context) {
    final agendaData = Provider.of<AgendaData>(context, listen: false);
    ContactData contact = ContactData.vacio(id: agendaData.contacts.length + 1);
    onEditContact(context, contact, isNew: true);
  }

  Future<void> onDeleteContact(
      BuildContext context, ContactData contact) async {
    final agendaData = Provider.of<AgendaData>(context, listen: false);
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          backgroundColor: const Color.fromARGB(255, 33, 31, 31),
          content: const Text(
            "¿Realmente quieres borrar el contacto?",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () async {
                agendaData.contacts.remove(contact);
                await agendaData.save();
                agendaData.notificar();
                Navigator.of(context).pop();
              },
              child: const Text('Sí', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void onEditLabels(BuildContext context, List<String> labels,
      {bool saveChanges = false}) {
    String initialLabels = labels
        .map((label) => label[0].toUpperCase() + label.substring(1))
        .join(", ");

    final TextEditingController labelController =
        TextEditingController(text: initialLabels);

    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 41, 40, 40),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: labelController,
                decoration: const InputDecoration(
                  hintText: "Amistad, Trabajo...",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: "Editar etiquetas",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String inputText = labelController.text;
                  List<String> updatedLabels = inputText
                      .split(",")
                      .where((label) => label.isNotEmpty)
                      .map((label) =>
                          label[0].toUpperCase() + label.substring(1).trim())
                      .toList();

                  if (saveChanges) {
                    final contact =
                        Provider.of<ContactData>(context, listen: false);
                    contact.labels = updatedLabels;
                    contact.notificar();

                    final agendaData =
                        Provider.of<AgendaData>(context, listen: false);
                    await agendaData.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Etiquetas actualizadas correctamente."),
                      ),
                    );
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color.fromARGB(235, 33, 31, 31),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Aplicar"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> onSort(BuildContext context) async {
    final agendaData = Provider.of<AgendaData>(context, listen: false);

    agendaData.contacts.sort((a, b) => a.name!.compareTo(b.name!));
    await agendaData.save();
    agendaData.notificar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Contactos ordenados por nombre")),
    );
  }
}
