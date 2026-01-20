// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  Future<User?> registerAccount(String email, String password) async {
    try {
      UserCredential userCredential =
          await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error en el registro: ${e.message}');
      return null;
    }
  }

  Future<User?> signInAccount(String email, String password) async {
    try {
      print(
          "Intentando iniciar sesión con email: $email y password: $password");
      UserCredential? userCredential = await _authInstance
          .signInWithEmailAndPassword(email: email, password: password);

      print("Inicio de sesión exitoso");
      return userCredential.user;
    } catch (e) {
      print("Error al iniciar sesión: $e");
      return null;
    }
  }
    // Guardar el usuario en local
  Future<void> saveUser(User user) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('uid', user.uid);
  }
  //checkea el usuario 
  Future<String?> checkUser() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('uid');
  }
  //Cerrar sesion
  Future<void> closeSesion() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('uid');
  }