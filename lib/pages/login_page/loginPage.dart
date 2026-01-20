// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:agenda/models/auth_service/firebase_auth.dart';
import 'package:agenda/pages/login_page/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool? isChecked = false;
  bool seePassword = true;
  ValueNotifier userCredential = ValueNotifier('');
  String? error;

  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return Scaffold(
      backgroundColor: Color.fromARGB(235, 33, 31, 31),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login to your account",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 30, 50, 20),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Text(
                      "Email",
                      style: TextStyle(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(235, 33, 31, 31),
                    prefixIcon: Icon(Icons.email, color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: inputBorder),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: inputBorder),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: seePassword,
                  decoration: InputDecoration(
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(235, 33, 31, 31),
                    prefixIcon: Icon(Icons.email, color: Colors.orange),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: inputBorder),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: inputBorder),
                    suffixIcon: IconButton(
                      icon: Icon(
                        seePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          seePassword = !seePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value;
                      });
                    },
                  ),
                  Text(
                    "Remember",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: _buttonLogin(context),
              ),
              _rowlinea,
              //_rowiconlogin,
              _createaccount,
            ]),
      ),
    );
  }

  Padding get _rowlinea => Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "or",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
          ],
        ),
      );
/*
  Row get _rowiconlogin => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: onGooglePresed,
              icon: Image.asset(
                "assets/images/google_icon.webp",
              )),
          IconButton(
              onPressed: onFacebookPresed,
              icon: Image.asset(
                "assets/images/facebook_icon.webp",
              )),
        ],
      );
*/
  TextButton _buttonLogin(BuildContext context) => TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.orange),
          minimumSize: WidgetStatePropertyAll(Size(300, 50)),
        ),
        onPressed: () async {
          User? user = await signInAccount(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
          if (isChecked = true && user != null) {
            saveUser(user!);
          }
          if (user != null) {
            Navigator.pushReplacementNamed(context, "/home");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Inicio de sesión fallido')),
            );
          }
        },
        child: Text(
          "Login",
          style:
              TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );

  Row get _createaccount => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Create account here:", style: TextStyle(color: Colors.white)),
          TextButton(
              onPressed: onCreatePressed,
              child: Text("Sign Up", style: TextStyle(color: Colors.white))),
        ],
      );

  void onGooglePresed() async {
  }

  void onFacebookPresed() {}

  void onCreatePressed() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => SignupPage()),
      (route) => false,
    );
  }
}