import 'package:http/http.dart' as http;
import 'package:local_market/Services/config.dart';
import 'dart:convert';

///Esta funcion hace una llamada a la API donde valida si [user] y [pass] existen dentro de la base de datos.
///
///**user**: hace referencia al correo electronico del usuario.
///
///**pass**: hace referencia a la contraseña del usuario
Future<dynamic> createProducts(
  String name,
  String descripcion,
  double precio,
  String oferta,
  String url,
  int negocio,
) async {
  await http.post(
    //Remplazar '${Config.apiKey}' por la URL de la API que estes usando.
    //Si estas trabajando de manera local y has descargado la API para este repositorio
    //crea un archivo config.dart en lib/service y pega el siguiente codigo:
    //class Config {
    //static const String apiKey = 'http://localhost/API_local_market';
    //}
    //
    //Si no has descargado el repositorio para la API descargalo: https://github.com/Litardo-Jardy/API_local_market
    Uri.parse('${Config.apiKey}/addProducts.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'nombre': name,
      'descripcion': descripcion,
      'precio': precio.toString(),
      'imagen': url,
      'oferta': oferta,
      'id_negocio': negocio.toString()
    }),
  );
}
