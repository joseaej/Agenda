import 'package:agenda/pages/contactDetailsPage.dart';
import 'package:agenda/datas/contactdata.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ContactDetailsPage(
        contact: Contact(
          id: 1,
          name: "John",
          surname: "Doe",
          email: "john.doe@gmail.com",
          phone: "555-1234",
          birthdate: DateTime(1996, 7, 19),
        ),
      ),
    );
  }
}
