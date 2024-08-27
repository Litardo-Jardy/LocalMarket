import 'package:flutter/material.dart';
import 'package:local_market/Pages/Login/validation.dart';
import 'package:local_market/Services/button.dart';
import 'package:local_market/Services/footer.dart';
import 'package:local_market/Services/registerBar.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

import 'package:local_market/State/sesion.dart';
import '../Initial/initial_screen.dart';

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
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "lib/assets/gradiant.png"), // Ruta de la imagen en assets
                fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el fondo
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 2.0, sigmaY: 2.0), // Intensidad del desenfoque
            child: Container(
              color: Colors.black.withOpacity(
                  0), // Color transparente para permitir ver la imagen difuminada
            ),
          ),
          ListView(children: [
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
                        const SizedBox(height: 20),
                        const NavigatorRegister(selectPages: "login"),
                        const SizedBox(
                          width: 370,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 30),
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
                              CustomField(
                                  size: 300,
                                  controller: _user,
                                  label: "Usuario",
                                  icon: const Icon(Icons.person)),
                              const SizedBox(height: 50.0),
                              CustomField(
                                  size: 300,
                                  controller: _pass,
                                  label: "Contraseña",
                                  icon: const Icon(Icons.lock)),
                              const SizedBox(height: 45.0),
                              SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    validation(
                                        _user.text, _pass.text, context, user);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFffca7b),
                                    foregroundColor: Colors.black87,
                                    shadowColor: Colors.black,
                                    elevation: 5,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: const Size(150, 50),
                                  ),
                                  child: const Text(
                                    'Ingresar',
                                    style: TextStyle(
                                      color: Colors.white, // Texto blanco
                                      fontSize: 20.0,
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
                                          color:
                                              Color.fromARGB(255, 47, 83, 182),
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
                              const CustomFooter()
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
        ]));
  }
}
