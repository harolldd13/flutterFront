import 'package:flutter/material.dart';
import 'package:psicolbienestar/services/categoriaService.dart';

class CategoriaApi extends StatelessWidget {
  final CategoriaService categoriaService =
      CategoriaService(); // Instancia del servicio de categoría

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Categoria>>(
      future: categoriaService.getCategorias(), // Obtener todas las categorías
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error al obtener las categorías');
        } else {
          final List<Categoria> categorias = snapshot.data ?? [];
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: ScrollPhysics(), // Permitir deslizar horizontalmente
            child: Row(
              children: [
                for (var categoria in categorias)
                  _buildCategoriaCard(context, categoria),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildCategoriaCard(BuildContext context, Categoria categoria) {
    return GestureDetector(
      onTap: () {
        // Navegar a la página de detalles de la categoría
        Navigator.pushNamed(
          context,
          "/detallesCategoria",
          arguments: categoria, // Pasar la categoría como argumento
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.5), // Color verde con opacidad
              spreadRadius: 0.1, // Extensión de la sombra
              blurRadius: 19, // Difuminado de la sombra
              offset: Offset(0, 2), // Desplazamiento de la sombra
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.all(10),
          child: SizedBox(
            width: 200, // Ancho de la tarjeta
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    // child: Image.asset(
                    //   'images/${categoria.imagen}', // Ruta de la imagen en la carpeta images
                    //   height: 170,
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.network(
                      categoria.imagen!,
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoria
                            .nombre, // Usar el nombre de la categoría desde la API
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 17, 210, 52),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        categoria
                            .descripcion, // Usar la descripción de la categoría desde la API
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
