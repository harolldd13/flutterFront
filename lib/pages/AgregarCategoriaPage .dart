import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:psicolbienestar/services/categoriaService.dart';

class AgregarCategoriaPage extends StatefulWidget {
  const AgregarCategoriaPage({Key? key}) : super(key: key);

  @override
  _AgregarCategoriaPageState createState() => _AgregarCategoriaPageState();
}

class _AgregarCategoriaPageState extends State<AgregarCategoriaPage> {
  late File _imagenFile;
  final _categoriaService = CategoriaService();
  final _formKey = GlobalKey<FormState>();
  late String _nombre;
  late String _descripcion;

  @override
  void initState() {
    super.initState();
    _imagenFile = File('ruta/por/defecto/imagen.jpg');
  }

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final imagenSeleccionada =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagenFile = File(imagenSeleccionada!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nueva Categoría'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa el nombre';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nombre = value!;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa la descripción';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _descripcion = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _seleccionarImagen,
                    child: Text('Seleccionar Imagen'),
                  ),
                  SizedBox(height: 10),
                  _imagenFile != null && _imagenFile.path.isNotEmpty
                      ? Container(
                          height: 100, // Ajusta la altura según tus necesidades
                          width: 100, // Ajusta la anchura según tus necesidades
                          child: Image.file(
                            _imagenFile,
                            fit: BoxFit.cover, // Ajusta el tamaño de la imagen
                          ),
                        )
                      : SizedBox(), // Mostrar la imagen seleccionada si existe
                  SizedBox(height: 20),
                 ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (_imagenFile != null) {
                        final nuevaCategoria = Categoria(
                          idCategoria: 0, // El ID será asignado por la API
                          nombre: _nombre,
                          descripcion: _descripcion, // Pasar el archivo de imagen
                        );
                        await _categoriaService.agregarCategoria(nuevaCategoria,_imagenFile);
                        Navigator.pop(context); // Regresar a la página anterior
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Por favor selecciona una imagen'),
                          ),
                        );
                      }
                    }
                  },
                    child: Text('Agregar Categoría'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
