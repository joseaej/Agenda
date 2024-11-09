// ignore_for_file: prefer_const_constructors

import 'package:agenda/models/contactdata.dart';
import 'package:agenda/pages/contactsPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ContactFormPage extends StatefulWidget {
  Contact contacto;
  ContactFormPage({super.key, required this.contacto});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController tecEmail;
  late TextEditingController tecNombre;
  late TextEditingController tecApellido;
  late TextEditingController tecTelefono;
  late TextEditingController tecFecha;
  @override
  initState() {
    tecEmail = TextEditingController(text: widget.contacto.email);
    tecNombre = TextEditingController(text: widget.contacto.name);
    tecApellido = TextEditingController(text: widget.contacto.surname);
    tecFecha = TextEditingController(
        text: DateFormat("MMM d, y").format((widget.contacto.birthdate != null)
            ? widget.contacto.birthdate!
            : DateTime.now()));
    tecTelefono = TextEditingController(text: widget.contacto.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme txtTheme = theme.textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 33, 31, 31),
        appBar: _appbar,
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: tecNombre,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Nombre",
                      labelStyle: TextStyle(color: Colors.white),
                      helperStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Nombre",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: tecApellido,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: "Apellidos",
                        labelStyle: TextStyle(color: Colors.white),
                        helperStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: "Apellidos",
                        errorStyle: TextStyle(color: Colors.red)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: tecEmail,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      helperStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: tecTelefono,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Telefono",
                      labelStyle: TextStyle(color: Colors.white),
                      helperStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Telefono",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    onTap: onDatePress,
                    readOnly: true,
                    controller: tecFecha,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Fecha de nacimiento",
                      labelStyle: TextStyle(color: Colors.white),
                      helperStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: "Fecha de nacimiento",
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  AppBar get _appbar => AppBar(
        backgroundColor: Color.fromARGB(255, 33, 31, 31),
        leading: IconButton(
            onPressed: onBackPresed,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          (widget.contacto.id == 0) ? "Nuevo Contacto" : "Edición de contacto",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: onCheckPressed, icon: Icon(Icons.check))
        ],
      );
  void onBackPresed() {
    Navigator.of(context).pop();
  }

  bool? onCheckPressed() {
    bool validacion = validate();
    if (validacion) {
      Navigator.pop(context, true);
      return true;
    } else {
      return false;
    }
  }

  bool validate() {
    bool condicion = true;
    setState(() {
      if (tecEmail.value.text.contains(RegExp(r'^(.+)@(\S+)$'))) {
        widget.contacto.email = tecEmail.value.text;
      } else {
        tecEmail.text = "Correo incorrecto";
        condicion = false;
      }

      if (tecNombre.value.text.contains(RegExp(r'^[A-Z][a-z]+$'))) {
        widget.contacto.name = tecNombre.value.text;
      } else {
        tecNombre.text = "Nombre invalido";
        condicion = false;
      }

      if (tecApellido.value.text.contains(RegExp(r'^[A-Z][a-z]+$'))) {
        widget.contacto.surname = tecApellido.value.text;
      } else {
        tecApellido.text = "Apellido invalido";
        condicion = false;
      }

      if (tecTelefono.value.text.contains(RegExp(r'^[679][0-9]{8}$'))) {
        widget.contacto.phone = tecTelefono.value.text;
      } else {
        tecTelefono.text = "Telefono invalido";
        condicion = false;
      }
    });
    return condicion;
  }

  void onDatePress() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      tecFecha.text = DateFormat("MMM d, y").format(date);
    } else {
      tecFecha.text = DateFormat("MMM d,y").format(widget.contacto.birthdate!);
    }
  }
}

class ResultadoProvider extends ChangeNotifier {
  bool? resultado;
  void setResultado(bool value) {
    resultado = value;
    notifyListeners();
  }
}
