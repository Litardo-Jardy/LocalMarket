import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_market/Pages/Register/getCoords.dart';
import 'package:local_market/Pages/Register/validation_client.dart';

import 'package:local_market/Services/button.dart';
import 'package:local_market/Services/footer.dart';
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

  Position? position;
  LocationPermission? permission;
  bool? serviceEnabled;
  bool isMapVisible = false;
  LatLng location = LatLng(0, 0);

  void _onTap(LatLng location) {
    setState(() {
      _location.text = "${location.latitude}|${location.longitude}";
      location = location;
      isMapVisible = false;
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
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Registro de cliente',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
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
                                  size: 290,
                                  controller: _name,
                                  label: "Nombre",
                                  icon: const Icon(Icons.person)),
                              const SizedBox(height: 30.0),
                              const TextLabel(title: 'Direccion email'),
                              const SizedBox(height: 8),
                              CustomField(
                                  size: 290,
                                  controller: _email,
                                  label: "Email",
                                  icon: const Icon(Icons.email)),
                              const SizedBox(height: 30.0),
                              const TextLabel(title: 'Ubicacion'),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomField(
                                      size: 188,
                                      controller: _location,
                                      label: "(Coordenadas)",
                                      icon: const Icon(Icons.location_city)),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: 95,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        serviceEnabled = await Geolocator
                                            .isLocationServiceEnabled();
                                        permission =
                                            await Geolocator.checkPermission();

                                        if (permission ==
                                            LocationPermission.denied) {
                                          permission = await Geolocator
                                              .requestPermission();
                                          if (permission ==
                                              LocationPermission.denied) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Permisos de ubicacion denegados'),
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        } else {
                                          Position newPosition =
                                              await Geolocator
                                                  .getCurrentPosition(
                                                      desiredAccuracy:
                                                          LocationAccuracy
                                                              .high);

                                          setState(() {
                                            isMapVisible = true;
                                            position = newPosition;
                                          });
                                          //_registerAndNavigate(name, pass, email, confirPass,
                                          //  "${position.latitude}|${position.longitude}", context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          backgroundColor:
                                              const Color(0xFFffca7b)),
                                      child: const Text(
                                        'Cargar',
                                        style: TextStyle(
                                          color: Colors.white, // Texto blanco
                                          fontSize: 11,
                                          letterSpacing: 2,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              const TextLabel(title: 'Contraseña'),
                              const SizedBox(height: 8),
                              CustomField(
                                  size: 290,
                                  controller: _pass,
                                  label: "Contraseña",
                                  icon: const Icon(Icons.lock)),
                              const SizedBox(height: 30.0),
                              const TextLabel(
                                  title: 'Confimacion de contraseña'),
                              const SizedBox(height: 8),
                              CustomField(
                                  size: 290,
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
                                        location,
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
          ],
        ),
        SizedBox(
          child: isMapVisible
              ? GetCoords(

                  /// height: double.infinity,
                  latitude: position!.latitude,
                  onTapMaps: _onTap,
                  longitude: position!.longitude)
              : null,
        )
      ]),
    );
  }
}
