import 'package:flutter/material.dart';
import 'package:local_market/Pages/Login/login.dart';

import 'package:geolocator/geolocator.dart';
import 'package:local_market/Pages/Register/validation_client.dart';

import 'package:local_market/Services/button.dart';

void main() {
  runApp(const RegisterCliente());
}

class RegisterCliente extends StatefulWidget {
  const RegisterCliente({super.key});

  @override
  State<RegisterCliente> createState() => _RegisterCliente();
}

class _RegisterCliente extends State<RegisterCliente> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _confirPass = TextEditingController();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _currentPosition;
  }

  @override
  void dispose() {
    _name.dispose();
    _pass.dispose();
    _email.dispose();
    _location.dispose();
    _confirPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: ListView(children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 370,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const SizedBox(
                      width: 390,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Unete como cliente',
                                style: TextStyle(
                                  color: Color(0xFFffca7b),
                                  fontSize: 37.5,
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
                              size: 350,
                              controller: _name,
                              label: "Nombre de usuario",
                              icon: const Icon(Icons.person)),
                          const SizedBox(height: 50.0),
                          CustomField(
                              size: 350,
                              controller: _email,
                              label: "Email",
                              icon: const Icon(Icons.email)),
                          const SizedBox(height: 50.0),
                          CustomField(
                              size: 350,
                              controller: _location,
                              label: "Ubicacion",
                              icon: const Icon(Icons.location_city)),
                          const SizedBox(height: 50.0),
                          CustomField(
                              size: 350,
                              controller: _pass,
                              label: "Contraseña",
                              icon: const Icon(Icons.lock)),
                          const SizedBox(height: 50.0),
                          CustomField(
                              size: 350,
                              controller: _confirPass,
                              label: "Confirmar contraseña",
                              icon: const Icon(Icons.lock)),
                          const SizedBox(height: 40.0),
                          SizedBox(
                            width: 350,
                            child: ElevatedButton(
                              onPressed: () async {
                                validationClient(
                                    _name.text,
                                    _pass.text,
                                    _email.text,
                                    _confirPass.text,
                                    _location.text,
                                    context);
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
                                'Unirse',
                                style: TextStyle(
                                  color: Colors.white, // Texto blanco
                                  fontSize: 27.0,
                                  letterSpacing: 2,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          SizedBox(
                            width: 350,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20.0),
                                const Text(
                                  '¿Ya tienes cuenta?',
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
                                                const Loggin()));
                                  },
                                  child: const Text(
                                    'Inicia sesion',
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
