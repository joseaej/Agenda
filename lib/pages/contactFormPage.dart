// ignore_for_file: prefer_const_constructors

import 'package:agenda/models/contact.provider.dart';
import 'package:agenda/models/contactdata.dart';
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
  void initState() {
    tecEmail = TextEditingController(text: widget.contacto.email);
    tecNombre = TextEditingController(text: widget.contacto.name);
    tecApellido = TextEditingController(text: widget.contacto.surname);
    tecTelefono = TextEditingController(text: widget.contacto.phone);
    tecFecha = TextEditingController(
      text: DateFormat("MMM d, y").format(
        widget.contacto.birthdate ?? DateTime.now(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 33, 31, 31),
        appBar: _appbar,
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              _buildTextField(tecNombre, "Nombre"),
              _buildTextField(tecApellido, "Apellidos"),
              _buildTextField(tecEmail, "Email"),
              _buildTextField(tecTelefono, "Telefono"),
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
                    hintText: "Fecha de nacimiento",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          hintText: labelText,
        ),
      ),
    );
  }

  AppBar get _appbar => AppBar(
        backgroundColor: Color.fromARGB(255, 33, 31, 31),
        leading: IconButton(
          onPressed: onBackPressed,
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          widget.contacto.id == 0 ? "Nuevo Contacto" : "Edición de contacto",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: onCheckPressed, icon: Icon(Icons.check)),
        ],
      );

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  bool onCheckPressed() {
  if (validate()) {
    widget.contacto.name = tecNombre.text;
    widget.contacto.surname = tecApellido.text;
    widget.contacto.email = tecEmail.text;
    widget.contacto.phone = tecTelefono.text;

    if (widget.contacto.birthdate == null && tecFecha.text.isEmpty) {
      widget.contacto.birthdate = DateTime.now();
    }

    Provider.of<ContactProvider>(context, listen: false).updateContact(widget.contacto);

    Navigator.pop(context, true);
    return true;
  } else {
    return false;
  }
}


  bool validate() {
    bool isValid = true;
    setState(() {
      if (tecEmail.value.text.contains(RegExp(r'^(.+)@(\S+)$'))) {
        widget.contacto.email = tecEmail.value.text;
      } else {
        tecEmail.text = "Correo incorrecto";
        isValid = false;
      }
    });
    return isValid;
  }

  void onDatePress() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: widget.contacto.birthdate ?? DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      tecFecha.text = DateFormat("MMM d, y").format(date);
      setState(() {
        widget.contacto.birthdate = date;
      });
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
