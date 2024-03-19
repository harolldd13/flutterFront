import 'package:flutter/material.dart';
import 'package:psicolbienestar/auth/Registro.dart';
import 'package:psicolbienestar/auth/home.dart';
import 'package:psicolbienestar/auth/login.dart';
import 'package:psicolbienestar/auth/splash.dart';
import 'package:psicolbienestar/pages/DetallesCategoriaPage.dart';
import 'package:psicolbienestar/pages/HomePage.dart';
import 'package:psicolbienestar/pages/TareaCategoriaPage.dart';
import 'package:psicolbienestar/pages/TareaPage.dart';
import 'package:psicolbienestar/pages/detallesPage.dart';
import 'package:psicolbienestar/widgets/recursosWidget.dart';
import 'package:psicolbienestar/pages/AgregarCategoriaPage%20.dart';
import 'package:psicolbienestar/pages/CategoriaCrudPage.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 16, 111, 219),
      ),
      initialRoute: 'Splash',
      routes: {
        'Splash':(BuildContext context) => Splash(key: UniqueKey()),
        "login": (context) => LoginScreen (),
        "detallesPage": (context) => DetallesPage(),
        "tareaPage": (context) => TareaPage(),
        "tareaCategoria": (context) => TareaCategoriaPage(),
        "/detallesCategoria": (context) => DetallesCategoriaPage(),
        'Home':(BuildContext context) => HomePage(key: UniqueKey()),
        'login' :(BuildContext context) => HomePageCategoria(key: UniqueKey()),
        'registro' :(BuildContext context) => registro(key: UniqueKey()),
        "agregarCategoria": (context) => AgregarCategoriaPage(),
        "crudCategoria": (context) => CategoriaCrudPage(),
      },
    );
  }
}
