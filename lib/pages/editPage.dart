// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agenda/datas/contactdata.dart';
import 'package:agenda/pages/contactDetailsPage.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Contact contact = Contact(id: 1);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 33, 31, 31),
        appBar: _appBar,
        body: _body,
      ),
    );
  }

  Widget get _body => Padding(
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
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ));
  AppBar get _appBar => AppBar(
        backgroundColor: const Color.fromARGB(235, 33, 31, 31),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Edición de un contacto",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
            onPressed: () => onBackIcon(), icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: onEditIcon, icon: const Icon(Icons.check)),
        ],
      );

  void onBackIcon() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactDetailsPage(
        contact: contact,
      ),
    ));
  }

  void onEditIcon() {}
}
