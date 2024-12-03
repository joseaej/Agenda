// ignore_for_file: prefer_const_constructors

import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/models/auth_service/firebase_auth.dart';
import 'package:agenda/models/contact.provider.dart';
import 'package:agenda/models/contactdata.dart';
import 'package:agenda/models/events_hub.dart';
import 'package:agenda/pages/contactsPage.dart';
import 'package:agenda/pages/login_page/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  AgendaData agenda = AgendaData();
  String? initialRoute = "/login";

  try {
    await agenda.load();
    final uid = await checkUser();
    if (uid != null) {
      initialRoute = "/home";
    }
  } catch (e) {
    debugPrint('Error durante la inicialización: $e');
  }

  runApp(MyApp(agenda: agenda, route: initialRoute));
}

class MyApp extends StatelessWidget {
  final AgendaData agenda;
  final String? route;

  const MyApp({super.key, required this.agenda, required this.route});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: agenda),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        ChangeNotifierProvider(create: (_) => ContactData()),
        ChangeNotifierProvider(create: (_) => EventsHub()),
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
        initialRoute: route,
        routes: {
          "/login": (context) => LoginScreen(),
          "/home": (context) => ContactPage(),
        },
      ),
    );
  }
}
