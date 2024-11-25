import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/models/contact.provider.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:agenda/models/events_hub.dart';
import 'package:agenda/pages/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
      final agenda = AgendaData();
    agenda.save;
    agenda.load();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: agenda),
        ChangeNotifierProvider(create: (_)=> EventsHub()),
        ChangeNotifierProvider(create: (_)=> ContactData()),
        ChangeNotifierProvider(create: (_)=> ContactProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agenda',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(235, 33, 31, 31)
          ),
          useMaterial3: true,
        ),
        home:  const Loadingpage(),
      ),
    );
  }
}

