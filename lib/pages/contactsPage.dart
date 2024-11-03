// ignore_for_file: prefer_const_constructors

import 'package:agenda/datas/agenda_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
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
        ),
      ),
    );
  }

  Widget _contactList() {
    return Consumer<AgendaData>(
      builder: (context, state, child) {
        return ListView.builder(
          itemCount: state.contacts.length,
          itemBuilder: (context, index) {
            final contact = state.contacts[index];
            return ListTile(
              leading: Icon(Icons.message, color: Colors.white),
              title: Row(
                children: [
                  Text(
                    "${contact.name!} ${contact.surname!}",
                    style: TextStyle(color: Colors.white),
                  ),
                   if (contact.isFavorite)
                    Padding(padding: EdgeInsets.fromLTRB(10,0,0,0),
                    child: Icon(Icons.star, color: Colors.white, size: 18),)  
                ],
              ),
              subtitle: Text(
                "${contact.email!}, ${contact.phone!}",
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                onPressed: onPointsPresed,
                icon: Icon(Icons.grid_view_rounded, color: Colors.white),
              ),
            );
          },
        );
      },
    );
  }

  Widget _listFavorite() {
    return Consumer<AgendaData>(
      builder: (context, state, child) {
        final favoriteContacts = state.contacts.where((contact) => contact.isFavorite).toList();
        return ListView.builder(
          itemCount: favoriteContacts.length,
          itemBuilder: (context, index) {
            final contact = favoriteContacts[index];
            return ListTile(
              leading: Icon(Icons.battery_unknown_outlined),
              title: Row(
                children: [
                  Text(
                    "${contact.name!} ${contact.surname!}",
                    style: TextStyle(color: Colors.white),
                  ),
                   if (contact.isFavorite)
                    Padding(padding: EdgeInsets.fromLTRB(10,0,0,0),
                    child: Icon(Icons.star, color: Colors.white, size: 18),)  
                ],
              ),
              subtitle: Text(
                "${contact.email!},${contact.phone!}",
                style: TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                onPressed: onPointsPresed,
                icon: Icon(Icons.grid_view_rounded, color: Colors.white),
              ),
            );
          },
        );
      },
    );
  }

  TabBar get _tabbar => TabBar(
    labelStyle: TextStyle(color: Color.fromARGB(255, 132, 97, 192),),
    unselectedLabelStyle: TextStyle(color: Colors.white),
    
    indicatorColor: Color.fromARGB(255, 132, 97, 192),
    tabs: const [
      Tab(
        icon: Icon(Icons.contacts,color: Color.fromARGB(255, 132, 97, 192),),
        text: "Contactos",
      ),
      Tab(
        icon: Icon(Icons.star,color: Color.fromARGB(255, 132, 97, 192),),
        text: "Favoritos",
      ),
    ],
  );

  AppBar get _appBar => AppBar(
    backgroundColor: Color.fromARGB(255, 33, 31, 31),
    title: Text("Agenda", style: TextStyle(color: Colors.white)),
    iconTheme: IconThemeData(color: Colors.white),
    actions: [
      IconButton(
        onPressed: onShortPresed,
        icon: Icon(FontAwesomeIcons.arrowDownAZ, color: Colors.white),
      ),
      IconButton(
        onPressed: onFilterPresed,
        icon: Icon(Icons.filter_list_alt, color: Colors.white),
      ),
    ],
  );

  void onPointsPresed() {}
  void onShortPresed() {}
  void onFilterPresed() {}
}
