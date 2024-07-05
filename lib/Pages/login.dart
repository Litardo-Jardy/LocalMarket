import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:local_market/Pages/dashboard.dart';
import 'package:local_market/State/sesion.dart';
import 'initial_screen.dart';

import 'dart:convert';

void main() {
  runApp(const Loggin());
}

class Loggin extends StatefulWidget {
  const Loggin({super.key});

  @override
  State<Loggin> createState() => _Loggin();
}

class _Loggin extends State<Loggin> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<StateSesion>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: ListView(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                //Logo and button;
                width: 370,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 370,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                                width: 250,
                                image: AssetImage('lib/assets/logo.png')),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Iniciar Sesion',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 38.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 2,
                                ),
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(height: 45.0),
                    SizedBox(
                      width: 380,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomField(controller: _user, label: "Usuario"),
                          const SizedBox(height: 50.0),
                          CustomField(controller: _pass, label: "Contraseña"),
                          const SizedBox(height: 45.0),
                          SizedBox(
                            width: 350,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_user.text.isEmpty || _pass.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Llene todos los campos'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                } else {
                                  List<String> data = await validationUser(
                                      _user.text, _pass.text);
                                  if (int.parse(data[0]) > 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Se accedio con exito'),
                                        backgroundColor: Colors.blue,
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                    user.setId(int.parse(data[0]));
                                    user.setName(data[1]);
                                    user.setCorreo(data[2]);
                                    user.setPass(data[3]);
                                    user.setLatitude(data[4]);
                                    user.setLongitude(data[5]);
                                    user.setTipo(int.parse(data[6]));
                                    user.setUrl(data[7]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboard()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Credenciales incorrectas'),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFffca7b),
                                foregroundColor: Colors.black87,
                                shadowColor: Colors.black,
                                elevation: 5,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                minimumSize: const Size(150, 50),
                              ),
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(
                                  color: Colors.white, // Texto blanco
                                  fontSize: 27.0,
                                  letterSpacing: 2,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50.0),
                          SizedBox(
                            width: 350,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20.0),
                                const Text(
                                  '¿No tienes cuenta?',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: 2,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InitialScreen()));
                                  },
                                  child: const Text(
                                    'Regístrate aquí',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 47, 83, 182),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '© 2024 AstroChat. Todos los derechos reservados.',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 182, 181, 181)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const CustomField({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          prefixIcon: const Icon(Icons.person),
        ),
        style: const TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }
}

//Functions:
void validation(String user, String pass) {}

//API calling:
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
    debugPrint("Error validate user: ${e.toString()}");
    return [];
  }
}
