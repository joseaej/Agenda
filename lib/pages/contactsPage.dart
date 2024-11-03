// ignore_for_file: prefer_const_constructors

import 'package:agenda/datas/agenda_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 33, 31, 31),
        body: Column(
          children: [
            Expanded(
              child: Consumer<AgendaData>(
                builder: (context, state, child) {
                  return ListView.builder(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = state.contacts[index];
                      return ListenableBuilder(
                        listenable: state,
                        builder: (context, child) => ListTile(
                          leading: Icon(Icons.message),
                          title: Text("${contact.name!} ${contact.surname!}",
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text("${contact.email!}, ${contact.phone!}",
                              style: TextStyle(color: Colors.white)),
                          trailing: IconButton(onPressed: onPointsPresed, icon: Icon(Icons.grid_view_rounded)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    
  }
  void onPointsPresed() {}
}
