import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';
import 'package:local_market/Pages/Register/api_register_negocio.dart';

import 'package:geolocator/geolocator.dart';

import 'package:local_market/Pages/Register/validation_negocio.dart';
import 'package:local_market/Pages/Register/getCoords.dart';
import 'package:local_market/Services/button.dart';
import 'package:local_market/Services/checkListInput.dart';
import 'package:local_market/Services/loadImage.dart';
import 'package:local_market/Services/loadMultipleImage.dart';
import 'package:local_market/Services/registerBar.dart';
import 'package:local_market/Services/textLabel.dart';

void main() {
  runApp(const RegisterNegocio());
}

class RegisterNegocio extends StatefulWidget {
  const RegisterNegocio({
    super.key,
  });

  @override
  State<RegisterNegocio> createState() => _RegisterNegocio();
}

class _RegisterNegocio extends State<RegisterNegocio> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _referencia = TextEditingController();
  final TextEditingController _horasApertura = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _confirPass = TextEditingController();

  String diasApertura = '';
  bool isVisible = true;

  String? _apertureHour;
  String? _closeHour;
  String? _selectedItem;

  List<String> multipleIMages = [];
  void onAddImage(String url) {
    setState(() {
      multipleIMages.add(url);
    });
  }

  List<String>? _items;
  List<String> hours = [
    "00:00am",
    "1:00am",
    "2:00am",
    "3:00am",
    "4:00am",
    "5:00am",
    "6:00am",
    "7:00am",
    "8:00am",
    "9:00am",
    "10:00am",
    "11;00am",
    "12:00pm",
    "13:00pm",
    "14:00pm",
    "15:00pm",
    "16:00pm",
    "17:00pm",
    "18:00pm",
    "19:00pm",
    "20:00pm",
    "21:00pm",
    "22:00pm",
    "23:00pm",
  ];

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
    categorys(updateCategorys);
  }

  void updateState(info) {
    setState(() {
      isVisible = !isVisible;
    });
    setState(() {
      _location.text = info;
    });
  }

  void updateCategorys(items) {
    setState(() {
      _items = items;
    });
  }

  void chooseDiasAperura(String options) {
    setState(() {
      diasApertura = options;
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _pass.dispose();
    _email.dispose();
    _location.dispose();
    _confirPass.dispose();
    _horasApertura.dispose();
    _descripcion.dispose();
    _referencia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 370,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const NavigatorRegister(selectPages: "negocio"),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: 380,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                              child: isVisible
                                  ? Column(
                                      children: [
                                        const TextLabel(
                                            title: "Categoria del negocio"),
                                        SizedBox(
                                          width: 300,
                                          child: DropdownButton<String>(
                                            hint: const Text('Categoria'),
                                            value: _selectedItem,
                                            isExpanded: true,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                            icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.blueAccent),
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _selectedItem = newValue;
                                              });
                                            },
                                            items: _items
                                                ?.map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title: 'Imagenes del negocio'),
                                        const SizedBox(height: 8),
                                        LoadMultipleImageWeb(
                                            onChangeImage: onAddImage,
                                            id: '896883'),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title: "Horario del negocio"),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 145,
                                                child: DropdownButton<String>(
                                                  hint: const Text('Apetura'),
                                                  value: _apertureHour,
                                                  isExpanded: true,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                  icon: const Icon(
                                                      Icons.lock_clock,
                                                      color: Colors.blueAccent),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      _apertureHour = newValue;
                                                    });
                                                  },
                                                  items: hours.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              SizedBox(
                                                width: 145,
                                                child: DropdownButton<String>(
                                                  hint: const Text('Cierre'),
                                                  value: _closeHour,
                                                  isExpanded: true,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                  icon: const Icon(
                                                      Icons.lock_clock,
                                                      color: Colors.blueAccent),
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      _closeHour = newValue;
                                                    });
                                                  },
                                                  items: hours.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ]),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title: 'Dias de apertura'),
                                        CheckboxListInput(
                                            onOptionChage: chooseDiasAperura),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title: 'Referencia de ubicacion'),
                                        const SizedBox(height: 8.0),
                                        CustomField(
                                            size: 290,
                                            controller: _referencia,
                                            label: 'Referencia',
                                            icon: const Icon(Icons.route)),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title: 'Descripcion del negocio'),
                                        const SizedBox(height: 8.0),
                                        CustomField(
                                            size: 290,
                                            controller: _descripcion,
                                            label: 'Descripcion',
                                            icon: const Icon(Icons.wordpress)),
                                        const SizedBox(height: 30.0),
                                        SizedBox(
                                          width: 350,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              bool next = validationNegocio(
                                                  _descripcion.text,
                                                  _referencia.text,
                                                  '$_apertureHour - $_closeHour',
                                                  diasApertura,
                                                  multipleIMages,
                                                  context,
                                                  _selectedItem);
                                              if (next) {
                                                setState(() {
                                                  isVisible = !isVisible;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFffca7b),
                                              foregroundColor: Colors.black87,
                                              shadowColor: Colors.black,
                                              elevation: 5,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                              ),
                                              minimumSize: const Size(150, 50),
                                            ),
                                            child: const Text(
                                              'Suguiente ->',
                                              style: TextStyle(
                                                color: Colors
                                                    .white, // Texto blanco
                                                fontSize: 27.0,
                                                letterSpacing: 2,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                            ),
                            SingleChildScrollView(
                              child: !isVisible
                                  ? Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              setState(() {
                                                isVisible = !isVisible;
                                              });
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                            child: const Text(
                                              '<- Volver',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 30),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const TextLabel(
                                            title: 'Logo/Imagen del negocio'),
                                        const SizedBox(height: 8),
                                        LoadImageWeb(
                                            onChangeImage: updateStateImage,
                                            id: "999191"),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title: 'Nombre del negocio'),
                                        const SizedBox(height: 8),
                                        CustomField(
                                            size: 290,
                                            controller: _name,
                                            label: 'Nombre',
                                            icon: const Icon(Icons.person)),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title:
                                                'Direccion email del negocio'),
                                        const SizedBox(height: 8),
                                        CustomField(
                                            size: 290,
                                            controller: _email,
                                            label: 'Email',
                                            icon: const Icon(Icons.email)),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title: 'Ubicacion del negocio'),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomField(
                                                size: 188,
                                                controller: _location,
                                                label: "(Coordenadas)",
                                                icon: const Icon(
                                                    Icons.location_city)),
                                            const SizedBox(width: 8),
                                            SizedBox(
                                              width: 95,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  serviceEnabled = await Geolocator
                                                      .isLocationServiceEnabled();
                                                  permission = await Geolocator
                                                      .checkPermission();

                                                  if (permission ==
                                                      LocationPermission
                                                          .denied) {
                                                    permission = await Geolocator
                                                        .requestPermission();
                                                    if (permission ==
                                                        LocationPermission
                                                            .denied) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Permisos de ubicacion denegados'),
                                                          backgroundColor:
                                                              Colors.red,
                                                          duration: Duration(
                                                              seconds: 3),
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
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    backgroundColor:
                                                        const Color(
                                                            0xFFffca7b)),
                                                child: const Text(
                                                  'Cargar',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // Texto blanco
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
                                            label: 'Contraseña',
                                            icon: const Icon(Icons.lock)),
                                        const SizedBox(height: 30.0),
                                        const TextLabel(
                                            title:
                                                'Confirmacion de contraseña'),
                                        const SizedBox(height: 8),
                                        CustomField(
                                            size: 290,
                                            controller: _confirPass,
                                            label: 'Contraseña',
                                            icon: const Icon(Icons.lock)),
                                        const SizedBox(height: 30.0),
                                        SizedBox(
                                          width: 290,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              validationPersonNegocio(
                                                  _name.text,
                                                  _email.text,
                                                  _pass.text,
                                                  _confirPass.text,
                                                  _descripcion.text,
                                                  _referencia.text,
                                                  '$_apertureHour - $_closeHour',
                                                  diasApertura,
                                                  location,
                                                  _location.text,
                                                  multipleIMages,
                                                  context,
                                                  _selectedItem);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFffca7b),
                                              foregroundColor: Colors.black87,
                                              shadowColor: Colors.black,
                                              elevation: 5,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                              ),
                                              minimumSize: const Size(150, 50),
                                            ),
                                            child: const Text(
                                              'Crear cuenta',
                                              style: TextStyle(
                                                color: Colors
                                                    .white, // Texto blanco
                                                fontSize: 27.0,
                                                letterSpacing: 2,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
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
          ],
        ),
        SizedBox(
          child: isMapVisible
              ? GetCoords(
                  latitude: position!.latitude,
                  onTapMaps: _onTap,
                  longitude: position!.longitude)
              : null,
        )
      ]),
    );
  }
}
