import 'package:flutter/material.dart';
import 'package:psicolbienestar/models/login.dart';
import 'package:psicolbienestar/pages/HomePage.dart';
import 'package:psicolbienestar/services/loginService.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      Usuario usuario = await ApiService.login(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );

      // Navega a HomePageCategoria después del inicio de sesión exitoso
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageCategoria()),
      );

      print('Inicio de sesión exitoso: ${usuario.nombre}');
    } catch (e) {
      print('Error al iniciar sesión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  labelText: 'Username', iconColor: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Password', iconColor: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              // Pasar el contexto actual
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
