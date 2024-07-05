import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> registerClient(String nombre, String correo, double latitud,
    double longitud, String pass, int tipo) async {
  final response = await http.post(
    Uri.parse('http://localhost/API_local_market/registerClient.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'user': nombre,
      'correo': correo,
      'pass': pass,
      'latitud': latitud.toString(),
      'longitud': longitud.toString(),
      'tipo': tipo.toString()
    }),
  );
  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    return responseBody['id'];
  } else {
    return 0;
  }
}
