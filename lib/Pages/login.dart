import 'package:flutter/material.dart';
import 'initial_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> validationUser(String user, String pass) async {
  final response = await http.post(
    Uri.parse('http://localhost/API_local_market/validationUser.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'user': user, 'pass': pass}),
  );

  try {
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> existing = jsonResponse['validation'];
    bool id = existing[0]['existing'];
    return id;
  } catch (e) {
    debugPrint("No se pudo ${e.toString()}");
    return false;
  }
}

void main() {
  runApp(const Loggin());
}

class Loggin extends StatelessWidget {
  const Loggin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50), // Semilla de color verde vibrante
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Local Market'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  void _userLatestValue() {
    final value = _user.text;
    debugPrint(value);
  }

  void _passLatestValue() {
    final value = _pass.text;
    debugPrint(value);
  }

  @override
  void initState() {
    super.initState();
    _user.addListener(_userLatestValue);
    _pass.addListener(_passLatestValue);
  }

  @override
  void dispose() {
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
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
                            alignment: Alignment
                                .bottomCenter, // Puedes ajustar esto según tus necesidades
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
                        SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _user,
                            decoration: InputDecoration(
                              labelText: 'Usuario',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          width: 350,
                          child: TextField(
                            controller: _pass,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 45.0),
                        SizedBox(
                          width: 350,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool existing =
                                  await validationUser(_user.text, _pass.text);
                              if (existing) {
                                debugPrint("Se accedio con exito");
                              } else {
                                debugPrint("No accedio con exito");
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
    );
  }
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Inicio de sesion'),
        content: Text(mensaje),
        actions: <Widget>[
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
