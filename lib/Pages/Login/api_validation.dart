import 'package:http/http.dart' as http;
import 'package:local_market/Services/config.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

///Esta funcion hace una llamada a la API donde valida si [user] y [pass] existen dentro de la base de datos.
///
///**user**: hace referencia al correo electronico del usuario.
///
///**pass**: hace referencia a la contraseña del usuario
Future<dynamic> validationUser(String user, String pass) async {
  final response = await http.post(
    //Remplazar '${Config.apiKey}' por la URL de la API que estes usando.
    //Si estas trabajando de manera local y has descargado la API para este repositorio
    //crea un archivo config.dart en lib/service y pega el siguiente codigo:
    //class Config {
    //static const String apiKey = 'http://localhost/API_local_market';
    //}
    //
    //Si no has descargado el repositorio para la API descargalo: https://github.com/Litardo-Jardy/API_local_market
    Uri.parse('${Config.apiKey}/getUser.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'user': user, 'pass': pass, 'id': "0"}),
  );

  try {
    final data = json.decode(response.body);
    List<String> result = List<String>.from(data["user"][0]);
    return result;
  } catch (e) {
    debugPrint("Error validate user: ${e.toString()}");
    return [];
  }
}
