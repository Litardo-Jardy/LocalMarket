import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_market/Services/config.dart';

//Registro de negocio general;
Future<int> registerNegocio(
    String name,
    String pass,
    String email,
    double latitud,
    double longitud,
    int tipo,
    String referencia,
    String horasApertura,
    String diasApertura,
    String descripcion,
    String? categoria) async {
  final response = await http.post(
    Uri.parse('${Config.apiKey}/registerNegocio.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String?, String?>{
      'user': name,
      'correo': email,
      'pass': pass,
      'latitud': latitud.toString(),
      'longitud': longitud.toString(),
      'tipo': tipo.toString(),
      'referencia': referencia,
      'horaApertura': horasApertura,
      'diasApertura': diasApertura,
      'descripcion': descripcion,
      'categoria': categoria
    }),
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['id'];
  } else {
    throw Exception('Error en la petición: ${response.statusCode}');
  }
}

//Añadiendo images a una tabla aparte relacionada con negocio;
Future<dynamic> addImage(int id, String url) async {
  await http.post(Uri.parse('${Config.apiKey}/addImage.php'),
      headers: <String, String>{
        'Content-Type': 'aplication/json; charset=UTF-8',
      },
      body: jsonEncode(<String?, String?>{'id': id.toString(), 'url': url}));
}

//Listado de categorias para la creacion de nogocios y las preferencias;
Future<void> categorys(Function updateCategorys) async {
  try {
    final response =
        await http.get(Uri.parse('${Config.apiKey}/getCategorys.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['categorys'] != null && data['categorys'] is List) {
        updateCategorys(List<String>.from(
            data['categorys'].map((item) => item[0] as String)));
      } else {
        throw Exception('Error al mostrar los datos');
      }
    } else {
      throw Exception('Error en la petición: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint("No se pudo ${e.toString()}");
  }
}
