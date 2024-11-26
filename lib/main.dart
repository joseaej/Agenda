import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/models/contact.provider.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:agenda/models/events_hub.dart';
import 'package:agenda/pages/contactsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

<<<<<<< HEAD
  final AgendaData agenda = AgendaData();
  await agenda.load();

  runApp(MyApp(agenda: agenda));
=======
  runApp(const MyApp());
>>>>>>> f2ace6ef491eba08cdbe049eb57e71457d4b7915
}

class MyApp extends StatelessWidget {
  final AgendaData agenda;

  const MyApp({super.key, required this.agenda});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: agenda),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        ChangeNotifierProvider(create: (_) => ContactData()),
        ChangeNotifierProvider(create: (_) => EventsHub())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agenda',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(235, 33, 31, 31),
          ),
          useMaterial3: true,
        ),
<<<<<<< HEAD
        home: const ContactPage(),
=======
        home:  const Loadingpage(),
>>>>>>> f2ace6ef491eba08cdbe049eb57e71457d4b7915
      ),
    );
  }
}
