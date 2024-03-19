import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriaService with ChangeNotifier {
  final String baseUrl = 'http://10.185.217.88:8000/API/Categoria/';

  Future<List<Categoria>> getCategorias() async {
    print('URL de la API: $baseUrl');
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => Categoria.fromJson(json)).toList();
    } else {
      print('Error al obtener las categorías: ${response.statusCode}');
      print('Mensaje de error: ${response.body}');
      throw Exception('Error al obtener las categorías');
    }
  }

  Future<void> agregarCategoria(Categoria categoria,File? imgFile) async {
    print(categoria);
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoria.toJson()),
    );
    if(imgFile!=null){
      
    }
    if (response.statusCode == 201) {
      notifyListeners();
    } else {
      throw Exception('Error al agregar la categoría');
    }
  }

  Future<void> actualizarCategoria(Categoria categoria) async {
    final url = '$baseUrl${categoria.idCategoria}/';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(categoria.toJson()),
    );
    
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Error al actualizar la categoría');
    }
  }

  Future<void> eliminarCategoria(int idCategoria) async {
    final url = '$baseUrl$idCategoria/';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 204) {
      notifyListeners();
    } else {
      throw Exception('Error al eliminar la categoría');
    }
  }
}

class Categoria {
  final int idCategoria;
  final String nombre;
  final String descripcion;
  final String? imagen;

  Categoria({
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    this.imagen,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        idCategoria: json["id_categoria"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id_categoria": idCategoria,
        "nombre": nombre,
        "descripcion": descripcion,
        "imagen": imagen,
      };
}
