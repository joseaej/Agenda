import 'package:agenda/models/agenda_data.dart';
import 'package:agenda/pages/contactsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loadingpage extends StatefulWidget {
  const Loadingpage({super.key});

  @override
  _LoadingpageState createState() => _LoadingpageState();
}

class _LoadingpageState extends State<Loadingpage> {
  @override
  void initState() {
    super.initState();
    _loadAgenda();
  }

  Future<void> _loadAgenda() async {
    final agenda = Provider.of<AgendaData>(context, listen: false);
    await agenda.load();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ContactPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
