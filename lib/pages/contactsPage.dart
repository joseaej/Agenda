// ignore_for_file: prefer_const_constructors

import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/models/contactdata.dart';
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
    var state = Provider.of<AgendaData>;
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
                .map((label) => label[0].toUpperCase() + label.substring(1))
                .map((label) => label.trim())
                .toList();
            contact.labels = updatedLabels;
            switch (
                (contact.labels.isEmpty) ? "Desconocido" : contact.labels[0]) {
              case "Amistad":
                icono = Icon(
                  Icons.emoji_emotions,
                  color: Colors.white,
                );
                break;
              case "Trabajo":
                icono = Icon(
                  Icons.business,
                  color: Colors.white,
                );
                break;
              case "Casa":
                icono = Icon(
                  Icons.house,
                  color: Colors.white,
                );
                break;
              case "Familia":
                icono = Icon(
                  Icons.family_restroom,
                  color: Colors.white,
                );
                break;
              case "Gym":
                icono = Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                );
                break;
              default:
                icono = Icon(
                  Icons.question_mark,
                  color: Colors.white,
                );
            }

            return ListTile(
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
                trailing: _popmenu);
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
            final List<String> updatedLabels = contact.labels
                .where((label) => label.isNotEmpty)
                .map((label) => label[0].toUpperCase() + label.substring(1))
                .map((label) => label.trim())
                .toList();
            contact.labels = updatedLabels;
            switch (
                (contact.labels.isEmpty) ? "Desconocido" : contact.labels[0]) {
              case "Amistad":
                icono = Icon(
                  Icons.emoji_emotions,
                  color: Colors.white,
                );
                break;
              case "Trabajo":
                icono = Icon(
                  Icons.business,
                  color: Colors.white,
                );
                break;
              case "Casa":
                icono = Icon(
                  Icons.house,
                  color: Colors.white,
                );
                break;
              case "Familia":
                icono = Icon(
                  Icons.family_restroom,
                  color: Colors.white,
                );
                break;
              case "Gym":
                icono = Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                );
                break;
              default:
                icono = Icon(
                  Icons.question_mark,
                  color: Colors.white,
                );
            }
            return ListTile(
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
                trailing: _popmenu);
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

  PopupMenuButton get _popmenu => PopupMenuButton(
        color: Color.fromARGB(255, 33, 31, 31),
        itemBuilder: (context) => <PopupMenuEntry<dynamic>>[
          PopupMenuItem(
              onTap: () =>
                  Navigator.of(context).push(EditPage() as Route<Object?>),
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
              onTap: () => Navigator.of(context).pop(EditPage()),
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.all(10)),
                  Icon(
                    Icons.abc,
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
                    Icons.abc_sharp,
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
