import 'package:flutter/material.dart';
import 'package:local_market/Pages/Products/create_products.dart';

void validationProducts(String name, String descripcion, double precio,
    String oferta, String url, int negocio, context) {
  if (name.isEmpty ||
      descripcion.isEmpty ||
      (precio == 0) ||
      oferta.isEmpty ||
      url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Llene todos los campos'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else if (name.length < 2) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('EL nombre debe tener mas de un caracter'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else if (descripcion.length > 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('La descripcion excede los caracteres permitidos'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else if (url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('La imagen no se cargo con exito'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else {
    //Llamada a la API para crear el nuevo producto;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('El nuevo producto se creo con exito'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewProducts(),
      ),
    );
  }
}
