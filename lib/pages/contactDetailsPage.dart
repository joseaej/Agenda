// ignore_for_file: prefer_const_constructors

import 'package:agenda/pages/editPage.dart';
import 'package:intl/intl.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:flutter/material.dart';

class ContactDetailsPage extends StatefulWidget {
  final Contact contact;
  const ContactDetailsPage({super.key, required this.contact});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  Icon icono = Icon(Icons.star_outline);
  bool presionar = false;
  Icon iconolabel = Icon(
    Icons.question_mark,
    color: Colors.white,
    size: 120,
  );
  _ContactDetailsPageState();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 33, 31, 31),
        appBar: _appbar,
        body: _body(widget.contact),
      ),
    );
  }

  AppBar get _appbar => AppBar(
        backgroundColor: const Color.fromARGB(235, 33, 31, 31),
        actions: [
          IconButton(onPressed: onFavIcon, icon: icono),
          IconButton(onPressed: onEditIcon, icon: const Icon(Icons.edit)),
        ],
      );

  Widget _body(Contact contact) => Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                alignment: Alignment.center,
                width: 200,
                height: 200,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(221, 24, 24, 24)),
                child: iconolabel),
            Text(
              (contact.name != null && contact.surname != null)
                  ? "${contact.name} ${contact.surname}"
                  : "",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Divider(
              color: Colors.white,
            ),
            TextButton(
              onPressed: () => onEmailPress(context, contact),
              child: ListTile(
                subtitleTextStyle: TextStyle(color: Colors.white),
                title: Text("Correo electronico",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                subtitle:
                    Text((contact.email ?? ""), style: TextStyle(fontSize: 20)),
                trailing: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            TextButton(
              onPressed: () => onPhonePress(context, contact),
              child: ListTile(
                subtitleTextStyle: TextStyle(color: Colors.white),
                title: Text("Telefono",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                subtitle:
                    Text((contact.phone ?? ""), style: TextStyle(fontSize: 20)),
                trailing: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Nacimiento",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        Text(
                          (contact.birthdate != null
                              ? DateFormat("MMM d, y")
                                  .format(contact.birthdate!)
                              : ""),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Edad",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        Text(
                          (DateTime.now().year - contact.birthdate!.year)
                              .toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            TextButton(
              onPressed: () => onLabelsPress(context, contact),
              child: ListTile(
                  subtitleTextStyle: TextStyle(color: Colors.white),
                  title: Text("Etiquetas",
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: Text(
                      (contact.labels.isNotEmpty)
                          ? contact.labels[0]
                          : "No asignada",
                      style: TextStyle(color: Colors.white, fontSize: 20))),
            ),
            Divider(
              color: Colors.white,
            ),
            Text("Added on ${(contact.birthdate ?? DateTime.now())}",
                style: TextStyle(color: Colors.white)),
            Text("Modified on ${contact.creation}",
                style: TextStyle(color: Colors.white)),
          ],
        ),
      );

  void onFavIcon() {
    setState(() {
      if (!presionar) {
        icono = const Icon(Icons.star_outlined);
        presionar = true;
      } else {
        icono = const Icon(Icons.star_outline);
        presionar = false;
      }
      print(presionar);
    });
  }

  void onEmailPress(BuildContext context, Contact contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Enviando email a ${contact.email ?? ""}"),
      ),
    );
  }

  void onLabelsPress(BuildContext context, Contact contact) {
    String initialLabels = contact.labels.map((label) {
      return label[0].toUpperCase() + label.substring(1);
    }).join(", ");

    TextEditingController labelController =
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
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String inputText = labelController.text;

                  List<String> updatedLabels = inputText
                      .split(",")
                      .where((label) => label.isNotEmpty)
                      .map((label) =>
                          label[0].toUpperCase() + label.substring(1))
                      .map((label) => label.trim())
                      .toList();

                  contact.labels = updatedLabels;
                  setState(() {
                    switch ((contact.labels.isEmpty)
                        ? "Desconocido"
                        : contact.labels[0]) {
                      case "Amistad":
                        iconolabel = Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 120,
                        );
                        break;
                      case "Trabajo":
                        iconolabel = Icon(
                          Icons.work,
                          color: Colors.white,
                          size: 120,
                        );
                        break;
                      case "casa":
                        iconolabel = Icon(
                          Icons.house,
                          color: Colors.white,
                          size: 120,
                        );
                        break;
                      case "Gym":
                        iconolabel = Icon(
                          Icons.sports_gymnastics,
                          color: Colors.white,
                          size: 120,
                        );
                        break;
                      default:
                        iconolabel = Icon(
                          Icons.question_mark,
                          color: Colors.white,
                          size: 120,
                        );
                    }
                  });
                  print("Etiquetas actualizadas: ${contact.labels}");

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color.fromARGB(235, 33, 31, 31),
                  foregroundColor: Colors.white,
                ),
                child: Text("Aplicar"),
              ),
            ],
          ),
        );
      },
    );
  }

  void onPhonePress(BuildContext context, Contact contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Llamando a ${contact.phone ?? ""}"),
      ),
    );
  }

  void onEditIcon() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditPage(),
    ));
  }
}
