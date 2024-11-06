import 'package:flutter/material.dart';

class Contact extends ChangeNotifier{
  final int id;
  String? name;
  String? surname;
  String? email;
  String? phone;
  DateTime? birthdate;
  DateTime creation;
  DateTime modification;
  bool isFavorite;
  List<String> labels;

  Contact({
    required this.id,
    this.name,
    this.surname,
    this.email,
    this.phone,
    this.birthdate,
    DateTime? creation,
    DateTime? modification,
    this.isFavorite = false,
    this.labels = const [],
  })  : creation = creation ?? DateTime.now(),
        modification = modification ?? DateTime.now();

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      phone: json['phone'],
      birthdate:
          json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      creation: DateTime.parse(json['creation']),
      modification: DateTime.parse(json['modification']),
      isFavorite: json['isFavorite'] ?? false,
      labels: List<String>.from(json['labels'] ?? []),
    );
  }

  @override
  String toString() {
    List<String> result = [];
    result.add('ID: $id');
    if (name != null) result.add('Name: $name');
    if (surname != null) result.add('Surname: $surname');
    if (email != null) result.add('Email: $email');
    if (phone != null) result.add('Phone: $phone');
    if (birthdate != null) {
      result.add('Birthdate: ${birthdate!.toIso8601String()}');
    }
    result.add('Creation: ${creation.toIso8601String()}');
    result.add('Modification: ${modification.toIso8601String()}');
    result.add('Is Favorite: $isFavorite');
    if (labels.isNotEmpty) result.add('Labels: ${labels.join(", ")}');

    return result.join('\n');
  }

  Contact copyWith({
    int? id,
    String? name,
    String? surname,
    String? email,
    String? phone,
    DateTime? birthdate,
    DateTime? creation,
    DateTime? modification,
    bool? isFavorite,
    List<String>? labels,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthdate: birthdate ?? this.birthdate,
      creation: creation ?? this.creation,
      modification: modification ?? this.modification,
      isFavorite: isFavorite ?? this.isFavorite,
      labels: labels ?? this.labels,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'creation': creation.toIso8601String(),
      'modification': modification.toIso8601String(),
      'isFavorite': isFavorite,
      'labels': labels,
    };
    if (name != null) data['name'] = name;
    if (surname != null) data['surname'] = surname;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (birthdate != null) data['birthdate'] = birthdate!.toIso8601String();

    return data;
  }

  void copyValuesFrom(Contact other) {
    name = other.name ?? name;
    surname = other.surname ?? surname;
    email = other.email ?? email;
    phone = other.phone ?? phone;
    birthdate = other.birthdate ?? birthdate;
    creation = other.creation;
    modification = DateTime.now();
    isFavorite = other.isFavorite;
    labels = List<String>.from(other.labels);
  }

  Icon changeIcon() {
    Icon iconolabel;
    switch (labels[0]) {
      case "Amistad":
        iconolabel = const Icon(
          Icons.person,
          color: Colors.white,
          size: 120,
        );
        break;
      case "Trabajo":
        iconolabel = const Icon(
          Icons.work,
          color: Colors.white,
          size: 120,
        );
        break;
      case "casa":
        iconolabel = const Icon(
          Icons.house,
          color: Colors.white,
          size: 120,
        );
        break;
      case "Gym":
        iconolabel = const Icon(
          Icons.sports_gymnastics,
          color: Colors.white,
          size: 120,
        );
        break;
      default:
        iconolabel = const Icon(
          Icons.question_mark,
          color: Colors.white,
          size: 120,
        );
    }
    return iconolabel;
  }
}
