import 'package:agenda/datas/agenda_data.dart';
import 'package:agenda/pages/contactDetailsPage.dart';
import 'package:agenda/datas/contactdata.dart';
import 'package:agenda/pages/contactsPage.dart';
import 'package:agenda/pages/editPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

var agenda = AgendaData(contacts: [
    Contact(id: 1, name: "John", surname: "Doe", email: "john.doe@gmail.com", phone: "555-1234", birthdate: DateTime(1996, 7, 19)),
    Contact(id: 2, name: "Jane", surname: "Smith", email: "jane.smith@example.com", phone: "555-5678", birthdate: DateTime(1990, 12, 5), isFavorite: true, labels: ["Work", "VIP"]),
    Contact(id: 3, name: "Alice", surname: "Johnson", email: "alice.johnson@example.com", phone: "555-8765", birthdate: DateTime(1985, 3, 15), labels: ["Family"]),
    Contact(id: 4, name: "Bob", surname: "Williams", email: "bob.williams@example.com", phone: "555-4321", birthdate: DateTime(1982, 8, 23), labels: ["Friend", "Gym"]),
    Contact(id: 5, name: "Chris", surname: "Evans", email: "chris.evans@example.com", phone: "555-8765", birthdate: DateTime(1992, 2, 20), isFavorite: true, labels: ["Work"]),
    Contact(id: 6, name: "Emma", surname: "Watson", email: "emma.watson@example.com", phone: "555-6789", birthdate: DateTime(1991, 4, 15), labels: ["VIP", "Work"]),
    Contact(id: 7, name: "George", surname: "Brown", email: "george.brown@example.com", phone: "555-2345", birthdate: DateTime(1987, 5, 10), labels: ["Friend"]),
    Contact(id: 8, name: "Laura", surname: "Taylor", email: "laura.taylor@example.com", phone: "555-3456", birthdate: DateTime(1995, 10, 30), isFavorite: true, labels: ["Family", "VIP"]),
    Contact(id: 9, name: "Michael", surname: "Clark", email: "michael.clark@example.com", phone: "555-4567", birthdate: DateTime(1983, 11, 22), labels: ["Friend", "Gym"]),
    Contact(id: 10, name: "Olivia", surname: "Martinez", email: "olivia.martinez@example.com", phone: "555-7890", birthdate: DateTime(1997, 1, 18), isFavorite: true, labels: ["Work"]),
    Contact(id: 11, name: "Daniel", surname: "Moore", email: "daniel.moore@example.com", phone: "555-6543", birthdate: DateTime(1994, 6, 14), labels: ["Family"]),
    Contact(id: 12, name: "Sophia", surname: "Lee", email: "sophia.lee@example.com", phone: "555-9876", birthdate: DateTime(1993, 8, 22), isFavorite: false, labels: ["VIP"]),
    Contact(id: 13, name: "James", surname: "Harris", email: "james.harris@example.com", phone: "555-2134", birthdate: DateTime(1998, 3, 9), labels: ["Gym"]),
    Contact(id: 14, name: "Liam", surname: "Clarkson", email: "liam.clarkson@example.com", phone: "555-5647", birthdate: DateTime(1992, 9, 25), isFavorite: true, labels: ["Work", "Family"]),
    Contact(id: 15, name: "Mia", surname: "Martinez", email: "mia.martinez@example.com", phone: "555-3465", birthdate: DateTime(1988, 7, 13), labels: ["VIP"]),
    Contact(id: 16, name: "Elijah", surname: "Taylor", email: "elijah.taylor@example.com", phone: "555-1765", birthdate: DateTime(1990, 11, 30), labels: ["Friend", "Family"]),
    Contact(id: 17, name: "Isabella", surname: "Allen", email: "isabella.allen@example.com", phone: "555-7654", birthdate: DateTime(1984, 4, 28), isFavorite: true, labels: ["Family"]),
    Contact(id: 18, name: "Aiden", surname: "Young", email: "aiden.young@example.com", phone: "555-9873", birthdate: DateTime(1995, 12, 16), labels: ["Gym"]),
    Contact(id: 19, name: "Emily", surname: "King", email: "emily.king@example.com", phone: "555-3125", birthdate: DateTime(1999, 2, 7), labels: ["VIP"]),
    Contact(id: 20, name: "Benjamin", surname: "Perez", email: "benjamin.perez@example.com", phone: "555-4562", birthdate: DateTime(1991, 10, 3), labels: ["Work", "Friend"]),
    Contact(id: 21, name: "Abigail", surname: "Robinson", email: "abigail.robinson@example.com", phone: "555-6547", birthdate: DateTime(1986, 3, 24), isFavorite: false),
    Contact(id: 22, name: "Lucas", surname: "Scott", email: "lucas.scott@example.com", phone: "555-4589", birthdate: DateTime(1982, 6, 29), labels: ["Friend"]),
    Contact(id: 23, name: "Amelia", surname: "Campbell", email: "amelia.campbell@example.com", phone: "555-7864", birthdate: DateTime(1994, 7, 15), labels: ["VIP"]),
    Contact(id: 24, name: "Henry", surname: "Turner", email: "henry.turner@example.com", phone: "555-2943", birthdate: DateTime(1990, 8, 20), labels: ["Family", "Work"]),
    Contact(id: 25, name: "Victoria", surname: "Phillips", email: "victoria.phillips@example.com", phone: "555-9156", birthdate: DateTime(1989, 9, 5), labels: ["Friend"]),
    Contact(id: 26, name: "Jack", surname: "Collins", email: "jack.collins@example.com", phone: "555-3675", birthdate: DateTime(1998, 1, 30), isFavorite: true, labels: ["Work"]),
    Contact(id: 27, name: "Harper", surname: "Evans", email: "harper.evans@example.com", phone: "555-4768", birthdate: DateTime(1995, 5, 14), labels: ["VIP"]),
    Contact(id: 28, name: "Alexander", surname: "Wright", email: "alexander.wright@example.com", phone: "555-2347", birthdate: DateTime(1983, 12, 19), labels: ["Friend", "Family"]),
    Contact(id: 29, name: "Grace", surname: "Baker", email: "grace.baker@example.com", phone: "555-8794", birthdate: DateTime(1987, 11, 11), isFavorite: false, labels: ["Gym"]),
    Contact(id: 30, name: "Sebastian", surname: "Green", email: "sebastian.green@example.com", phone: "555-2143", birthdate: DateTime(1993, 4, 18), labels: ["Work"]),
  ]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => agenda,
      child: MaterialApp(
      title: 'Agenda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(235, 33, 31, 31)),
        useMaterial3: true,
      ),
      home: const ContactPage()
      )
    );
  }
}
