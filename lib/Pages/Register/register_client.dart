import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:local_market/Pages/Login/login.dart';

import 'package:geolocator/geolocator.dart';
import 'package:local_market/Pages/Register/validation_client.dart';

import 'package:local_market/Services/button.dart';

import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  String image = 'null';
  bool isImagen = false;
  html.File? _imageFile;

  Future<void> setImage(
      html.File? images, String folder, String id, Function updateState) async {
    final uri = Uri.parse('http://localhost/SkyLocal/setImage.php');
    var request = http.MultipartRequest('POST', uri);

    request.fields['Folder'] = folder;
    request.fields['id'] = id;

    var reader = html.FileReader();
    reader.readAsArrayBuffer(images as html.Blob);
    await reader.onLoad.first;

    var imageData = reader.result as Uint8List;
    request.files.add(http.MultipartFile.fromBytes(
      'Image',
      imageData,
      filename: images?.name,
    ));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = json.decode(responseData);
      setState(() {
        updateState(data['request'][0][0], data['request'][0][1]);
      });
    } else {
      final data = json.decode(responseData);
      setState(() {
        updateState(false, data['request'][0][1]);
      });
    }
  }

  void updateStateImage(bool isimage, String images) {
    setState(() {
      isImagen = isimage;
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
      backgroundColor: const Color(0xFFE0E0E0),
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
                    const SizedBox(height: 30),
                    ClipOval(
                        child: (image != 'null' && image.isNotEmpty)
                            ? Image.network(
                                image,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error_outline),
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              )),
                    const SizedBox(height: 13),
                    ElevatedButton(
                      onPressed: () async {
                        html.FileUploadInputElement uploadInput =
                            html.FileUploadInputElement();
                        uploadInput.accept = 'image/*';
                        uploadInput.click();

                        uploadInput.onChange.listen((e) {
                          final files = uploadInput.files;
                          if (files!.isNotEmpty) {
                            setState(() {
                              _imageFile = files.first;
                            });
                            setImage(_imageFile, 'Angelito/', '1000',
                                updateStateImage);
                          }
                        });
                      },
                      child: const Text('Elegir imagen'),
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: 380,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomField(
                              size: 300,
                              controller: _name,
                              label: "Nombre y apelllido",
                              icon: const Icon(Icons.person)),
                          const SizedBox(height: 20.0),
                          CustomField(
                              size: 300,
                              controller: _email,
                              label: "Email",
                              icon: const Icon(Icons.email)),
                          const SizedBox(height: 20.0),
                          CustomField(
                              size: 300,
                              controller: _location,
                              label: "Ubicacion",
                              icon: const Icon(Icons.location_city)),
                          const SizedBox(height: 20.0),
                          CustomField(
                              size: 300,
                              controller: _pass,
                              label: "Contraseña",
                              icon: const Icon(Icons.lock)),
                          const SizedBox(height: 20.0),
                          CustomField(
                              size: 300,
                              controller: _confirPass,
                              label: "Confirmacion de contraseña",
                              icon: const Icon(Icons.lock)),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: 300,
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
                                  borderRadius: BorderRadius.circular(10),
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
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Loggin()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007ACC),
                                foregroundColor: Colors.black87,
                                shadowColor: Colors.black,
                                elevation: 5,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(150, 50),
                              ),
                              child: const Text(
                                'Iniciar sesion',
                                style: TextStyle(
                                  color: Colors.white, // Texto blanco
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
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
