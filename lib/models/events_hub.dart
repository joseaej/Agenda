import 'package:agenda/datas/messages.dart';
import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/models/contact.provider.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:agenda/pages/contactFormPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsHub extends ChangeNotifier {
  String error="";
  bool isError=false;
  bool isSorted = false;
  onEditContact(BuildContext context, ContactData contact, {bool isNew = false}) async{
    try {
      ContactData newContact = contact.copyWith();
      final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ContactFormPage(contacto: newContact)));
      if (result != null) {
        contact.copyValuesFrom(newContact);
        contact.modification = DateTime.now();
        Provider.of<AgendaData>(context, listen: false).notificar();
        if (isNew==false) {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Contacto editado con exito")));
        }else{
          Provider.of<AgendaData>(context, listen: false).contacts.add(newContact);
          Provider.of<AgendaData>(context, listen: false).notificar();
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Contacto creado con exito")));
        }
      }else{
        isError = true;
        error = "Error en la modificacion del contacto";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)));
      }
    } catch (e) {
      isError = true;
      error = "Ocurrió un error: $e";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)));
    } finally{
      agenda.save();
    }
  }
  onCreateContact(BuildContext context){
    ContactData contact = ContactData.vacio(id: agenda.contacts.length+1);
    agenda.save;
    onEditContact(context, contact,isNew: true);
  }
  onDeleteContact(BuildContext context, ContactData contact)async{
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          backgroundColor: const Color.fromARGB(255, 33, 31, 31),
          content: const Text("¿Realmente quires borrar el contacto?",style: TextStyle(color: Colors.white)),
          actions: [
            TextButton(
            onPressed: () { Navigator.of(context).pop(); },
            child: const Text('No',style: TextStyle(color: Colors.white)),
            ),
            TextButton(
            onPressed: () {
              Provider.of<AgendaData>(context, listen: false).contacts.remove(contact);
              Provider.of<AgendaData>(context, listen: false).notificar();
              agenda.save();
              Navigator.of(context).pop(); 
            },
            child: const Text('Si',style: TextStyle(color: Colors.white)),
            ),
          ],
       );
      },
    );
  }
  void onEditLabels(BuildContext context, List<String> labels, {bool saveChanges = false}) {
  String initialLabels = labels
      .map((label) => label[0].toUpperCase() + label.substring(1))
      .join(", ");

  // Crear un controlador para el campo de texto
  final TextEditingController labelController = TextEditingController(text: initialLabels);

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
            // Campo de texto para editar etiquetas
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
              onPressed: () {
                String inputText = labelController.text;
                List<String> updatedLabels = inputText
                    .split(",")
                    .where((label) => label.isNotEmpty)
                    .map((label) => label[0].toUpperCase() + label.substring(1).trim())
                    .toList();

                if (saveChanges) {
                  var contacto = Provider.of<ContactData>(context, listen: false);
                  contacto.labels = updatedLabels;
                  contacto.notificar();
                  notifyListeners();

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

  onSort(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
      var contactProvider = Provider.of<AgendaData>(context, listen: false);

      contactProvider.contacts.sort((a, b) {
        return isSorted
            ? a.name!.compareTo(b.name!)
            : b.name!.compareTo(a.name!);
      });

      isSorted = !isSorted;

      contactProvider.notifyListeners();
      notifyListeners();
      agenda.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isSorted
              ? "Contactos ordenados de forma ascendente"
              : "Contactos ordenados de forma descendente"),
        ),
      );
    });
  }
}