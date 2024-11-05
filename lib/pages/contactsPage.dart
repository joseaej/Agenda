// ignore_for_file: prefer_const_constructors

import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:agenda/pages/contactDetailsPage.dart';
import 'package:agenda/pages/editPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Icon icono = Icon(Icons.battery_unknown_outlined);
  bool abcshort = true;
  Icon iconoord = Icon(FontAwesomeIcons.arrowDownAZ);
  List<String> updatedLabels = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<AgendaData>(builder: (context, state, child) {
      return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 33, 31, 31),
            appBar: _appBar,
            bottomNavigationBar: _tabbar,
            body: TabBarView(
              children: [
                _contactList(),
                _listFavorite(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop(EditPage());
              },
              backgroundColor: Color.fromARGB(255, 132, 97, 192),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        ),
      );
    });
  }

  Widget _contactList() {
    return Consumer<AgendaData>(
      builder: (context, state, child) {
        return ListView.builder(
          itemCount: state.contacts.length,
          itemBuilder: (context, index) {
            final contact = state.contacts[index];

            updatedLabels = contact.labels
                .where((label) => label.isNotEmpty)
                .map((label) =>
                    label.trim().replaceFirst(label[0], label[0].toUpperCase()))
                .toList();

            final iconMap = {
              "Amistad": Icons.emoji_emotions,
              "Trabajo": Icons.business,
              "Casa": Icons.house,
              "Familia": Icons.family_restroom,
              "Gym": Icons.fitness_center,
            };

            icono = Icon(
              iconMap[contact.labels.isEmpty
                      ? "Desconocido"
                      : contact.labels[0]] ??
                  Icons.question_mark,
              color: Colors.white,
            );

            return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ContactDetailsPage(contact: contact))),
                leading: icono,
                title: Row(
                  children: [
                    Text(
                      "${contact.name!} ${contact.surname!}",
                      style: TextStyle(color: Colors.white),
                    ),
                    if (contact.isFavorite)
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Icon(Icons.star, color: Colors.white, size: 18),
                      )
                  ],
                ),
                subtitle: Text(
                  "${contact.email!}, ${contact.phone!}",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: _popmenu(contact));
          },
        );
      },
    );
  }

  Widget _listFavorite() {
    return Consumer<AgendaData>(
      builder: (context, state, child) {
        final favoriteContacts =
            state.contacts.where((contact) => contact.isFavorite).toList();
        return ListView.builder(
          itemCount: favoriteContacts.length,
          itemBuilder: (context, index) {
            final contact = favoriteContacts[index];

            updatedLabels = contact.labels
                .where((label) => label.isNotEmpty)
                .map((label) =>
                    label.trim().replaceFirst(label[0], label[0].toUpperCase()))
                .toList();

            final iconMap = {
              "Amistad": Icons.emoji_emotions,
              "Trabajo": Icons.business,
              "Casa": Icons.house,
              "Familia": Icons.family_restroom,
              "Gym": Icons.fitness_center,
            };

            final icono = Icon(
              iconMap[contact.labels.isEmpty
                      ? "Desconocido"
                      : contact.labels[0]] ??
                  Icons.question_mark,
              color: Colors.white,
            );

            return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ContactDetailsPage(contact: contact))),
                leading: icono,
                title: Row(
                  children: [
                    Text(
                      "${contact.name!} ${contact.surname!}",
                      style: TextStyle(color: Colors.white),
                    ),
                    if (contact.isFavorite)
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Icon(Icons.star, color: Colors.white, size: 18),
                      )
                  ],
                ),
                subtitle: Text(
                  "${contact.email!},${contact.phone!}",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: _popmenu(contact));
          },
        );
      },
    );
  }

  TabBar get _tabbar => TabBar(
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 132, 97, 192),
        ),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        indicatorColor: Color.fromARGB(255, 132, 97, 192),
        tabs: const [
          Tab(
            icon: Icon(
              Icons.contacts,
            ),
            text: "Contactos",
          ),
          Tab(
            icon: Icon(
              Icons.star,
            ),
            text: "Favoritos",
          ),
        ],
      );

  PopupMenuButton _popmenu(Contact contacto) => PopupMenuButton<int>(
        onSelected: (int result) {
          if (result == 1) {
            /* Ver detalles (esta es la opción) */
          } else if (result == 2) {
            /* Editar (la implementaremos en Ejercicios 3.3) */
          } else if (result == 3) {
            /* Borrar (la implementaremos en el ejercicio 7) */
          }
        },
        color: Color.fromARGB(255, 33, 31, 31),
        itemBuilder: (context) => <PopupMenuEntry<int>>[
          PopupMenuItem(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ContactDetailsPage(
                      contact: contacto,
                    ),
                  )),
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.all(10)),
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                  Text(
                    "Ver",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          PopupMenuItem(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EditPage())),
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.all(10)),
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  Text(
                    "Editar",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          PopupMenuItem(
              onTap: () => Navigator.of(context).pop(EditPage()),
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.all(10)),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
        ],
        icon: Icon(Icons.more_vert, color: Colors.white),
      );
  AppBar get _appBar => AppBar(
        backgroundColor: Color.fromARGB(255, 33, 31, 31),
        title: Text("Agenda", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: onShortPresed,
            icon: iconoord,
          ),
          IconButton(
            onPressed: onFilterPresed,
            icon: Icon(Icons.filter_list_alt, color: Colors.white),
          ),
        ],
      );

  void onPointsPresed() {}
  void onShortPresed() {
    setState(() {
      if (abcshort) {
        iconoord = Icon(FontAwesomeIcons.arrowDownAZ);
        abcshort = false;
        Provider.of<AgendaData>(context, listen: false)
            .contacts
            .sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        iconoord = Icon(FontAwesomeIcons.arrowDownZA);
        abcshort = true;
        Provider.of<AgendaData>(context, listen: false)
            .contacts
            .sort((a, b) => b.name!.compareTo(a.name!));
      }
    });
  }

  void onFilterPresed() {}
}
