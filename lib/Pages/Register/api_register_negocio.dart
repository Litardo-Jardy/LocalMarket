import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

Future<dynamic> registerNegocio(
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
  await http.post(
    Uri.parse('http://localhost/API_local_market/registerNegocio.php'),
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
}

Future<void> categorys(Function updateCategorys) async {
  try {
    final response = await http
        .get(Uri.parse('http://localhost/API_local_market/getCategorys.php'));

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
