import 'package:agenda/datas/messages.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:agenda/pages/contactFormPage.dart';
import 'package:agenda/pages/contactsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: agenda),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Agenda',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(235, 33, 31, 31)),
            useMaterial3: true,
          ),
          home: ContactPage(),
        ));
  }
}
