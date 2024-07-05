import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';

Future<dynamic> validationUser(String user, String pass) async {
  final response = await http.post(
    Uri.parse('${dotenv.env['API_KEY']}/getUser.php'),
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
    debugPrint("No se pudieron cargar los datos. Error: ${e.toString()}");
    return [];
  }
}
