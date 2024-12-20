// ignore_for_file: prefer_const_constructors

import 'package:agenda/models/events_hub.dart';
import 'package:agenda/pages/contactsPage.dart';
import 'package:intl/intl.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactDetailsPage extends StatefulWidget {
  ContactData contact;
  ContactDetailsPage({super.key, required this.contact});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late var contactprov = Provider.of<ContactData>(context);
  var events_hub = EventsHub();
  Icon? iconStar;
  bool presionar = false;
  late Icon iconolabel;
  @override
  void initState() {
    super.initState();
    contactprov = widget.contact;
    contactprov.notificar();
    if (contactprov.isFavorite) {
      iconStar = Icon(
        Icons.star,
        color: Colors.white,
      );
    } else {
      iconStar = Icon(Icons.star_outline, color: Colors.white);
    }
    iconolabel = getContactIcon(contactprov.labels);
  }

  Icon getContactIcon(List<String> labels) {
    final iconMap = {
      "Amistad": Icons.emoji_emotions,
      "Trabajo": Icons.business,
      "Casa": Icons.house,
      "Familia": Icons.family_restroom,
      "Gym": Icons.fitness_center,
    };

    return Icon(
      iconMap[labels.isEmpty ? "Desconocido" : labels[0]] ??
          Icons.question_mark,
      color: Colors.white,
      size: 120,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 33, 31, 31),
        appBar: _appbar(contactprov),
        body: SingleChildScrollView(
          child: _body(contactprov),
        ),
      ),
    );
  }

  AppBar _appbar(ContactData contact) => AppBar(
        backgroundColor: const Color.fromARGB(235, 33, 31, 31),
        leading: IconButton(
            onPressed: () => onBackIcon(),
            icon: Icon(Icons.arrow_back, color: Colors.white)),
        actions: [
          IconButton(onPressed: () => onFavIcon(contact), icon: iconStar!),
          IconButton(
              onPressed: () {
                events_hub.onEditContact(context,contact);
              },
              icon: const Icon(Icons.edit, color: Colors.white)),
        ],
      );

  Widget _body(ContactData contact) => Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                alignment: Alignment.center,
                width: 150,
                height: 150,
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
                          (DateTime.now().year - ((contact.birthdate!=null)?contact.birthdate!.year:DateTime.now().year))
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
              onPressed: () => events_hub.onEditLabels(context,contact.labels),
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

  void onBackIcon() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactPage(),
    ));
  }

  void onFavIcon(ContactData contact) {
    setState(() {
      if (!presionar) {
        iconStar = const Icon(Icons.star_outlined, color: Colors.white);
        presionar = true;
      } else {
        iconStar = const Icon(Icons.star_outline, color: Colors.white);
        presionar = false;
      }
      contact.isFavorite = presionar;
      print(presionar);
    });
  }

  void onEmailPress(BuildContext context, ContactData contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Enviando email a ${contact.email ?? ""}"),
      ),
    );
  }

  void onPhonePress(BuildContext context, ContactData contact) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Llamando a ${contact.phone ?? ""}"),
      ),
    );
  }
}
