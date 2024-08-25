import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:geolocator/geolocator.dart';
import 'package:local_market/Pages/Register/validation_client.dart';

import 'package:local_market/Services/button.dart';
import 'package:local_market/Services/loadImage.dart';
import 'package:local_market/Services/registerBar.dart';
import 'package:local_market/Services/textLabel.dart';

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

  String image = '';
  bool isImagen = false;

  void updateStateImage(bool isImage, String images) {
    setState(() {
      isImagen = isImage;
      image = images;
    });
  }

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
      backgroundColor: const Color(0xFFFFFFFF),
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
        ListView(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 370,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const NavigatorRegister(selectPages: "cliente"),
                        const SizedBox(height: 30),
                        const TextLabel(title: "Imagen de perfil"),
                        const SizedBox(height: 8),
                        LoadImageWeb(
                            id: '999992', onChangeImage: updateStateImage),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: 380,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const TextLabel(title: 'Nombre de usuario'),
                              const SizedBox(height: 8),
                              CustomField(
                                  size: 300,
                                  controller: _name,
                                  label: "Nombre",
                                  icon: const Icon(Icons.person)),
                              const SizedBox(height: 30.0),
                              const TextLabel(title: 'Direccion email'),
                              const SizedBox(height: 8),
                              CustomField(
                                  size: 300,
                                  controller: _email,
                                  label: "Email",
                                  icon: const Icon(Icons.email)),
                              const SizedBox(height: 30.0),
                              const TextLabel(title: 'Ubicacion'),
                              const SizedBox(height: 8),
                              CustomField(
                                  size: 300,
                                  controller: _location,
                                  label: "Ubicacion",
                                  icon: const Icon(Icons.location_city)),
                              const SizedBox(height: 30.0),
                              const TextLabel(title: 'Contraseña'),
                              const SizedBox(height: 8),
                              CustomField(
                                  size: 300,
                                  controller: _pass,
                                  label: "Contraseña",
                                  icon: const Icon(Icons.lock)),
                              const SizedBox(height: 30.0),
                              const TextLabel(
                                  title: 'Confimacion de contraseña'),
                              const SizedBox(height: 8),
                              CustomField(
                                  size: 300,
                                  controller: _confirPass,
                                  label: "Contraseña",
                                  icon: const Icon(Icons.lock)),
                              const SizedBox(height: 40.0),
                              SizedBox(
                                width: 290,
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
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: const Size(150, 50),
                                  ),
                                  child: const Text(
                                    'Crear cuenta',
                                    style: TextStyle(
                                      color: Colors.white, // Texto blanco
                                      fontSize: 20,
                                      letterSpacing: 2,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  '© 2024 AstroChat. Todos los derechos reservados.',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 182, 181, 181)),
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
          ],
        ),
      ]),
    );
  }
}
