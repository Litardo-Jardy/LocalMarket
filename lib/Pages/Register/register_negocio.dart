import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:local_market/Pages/Login/login.dart';
import 'package:local_market/Pages/Register/api_register_negocio.dart';

import 'package:local_market/Pages/Register/validation_negocio.dart';

import 'package:local_market/Services/button.dart';
import 'package:local_market/Services/registerBar.dart';

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
  final TextEditingController _diasApertura = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _confirPass = TextEditingController();
  bool isVisible = true;
  String? _selectedItem;
  List<String>? _items;

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

  @override
  void dispose() {
    _name.dispose();
    _pass.dispose();
    _email.dispose();
    _location.dispose();
    _confirPass.dispose();
    _horasApertura.dispose();
    _diasApertura.dispose();
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
                                        SizedBox(
                                          width: 300,
                                          child: DropdownButton<String>(
                                            hint: const Text(
                                                'Categoria del negocio'),
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
                                        CustomField(
                                            size: 350,
                                            controller: _referencia,
                                            label: 'Referencia',
                                            icon: const Icon(Icons.route)),
                                        const SizedBox(height: 30.0),
                                        CustomField(
                                            size: 350,
                                            controller: _horasApertura,
                                            label: 'Horas de apertura',
                                            icon: const Icon(Icons.timer)),
                                        const SizedBox(height: 30.0),
                                        CustomField(
                                            size: 350,
                                            controller: _diasApertura,
                                            label: 'Dias de apertura',
                                            icon: const Icon(
                                                Icons.calendar_view_day)),
                                        const SizedBox(height: 30.0),
                                        CustomField(
                                            size: 350,
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
                                                  _horasApertura.text,
                                                  _diasApertura.text,
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
                                              'Unirte',
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
                                        CustomField(
                                            size: 350,
                                            controller: _name,
                                            label: 'Nombre de usuario',
                                            icon: const Icon(Icons.person)),
                                        const SizedBox(height: 50.0),
                                        CustomField(
                                            size: 350,
                                            controller: _email,
                                            label: 'Email',
                                            icon: const Icon(Icons.email)),
                                        const SizedBox(height: 50.0),
                                        CustomField(
                                            size: 350,
                                            controller: _location,
                                            label: 'Ubicacion',
                                            icon: const Icon(
                                                Icons.location_city)),
                                        const SizedBox(height: 50.0),
                                        CustomField(
                                            size: 350,
                                            controller: _pass,
                                            label: 'Contraseña',
                                            icon: const Icon(Icons.lock)),
                                        const SizedBox(height: 50.0),
                                        CustomField(
                                            size: 350,
                                            controller: _confirPass,
                                            label: ' Contraseña',
                                            icon: const Icon(Icons.lock)),
                                        const SizedBox(height: 50.0),
                                        SizedBox(
                                          width: 350,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              validationPersonNegocio(
                                                  _name.text,
                                                  _email.text,
                                                  _pass.text,
                                                  _confirPass.text,
                                                  context,
                                                  updateState);
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
                                              'Siguiente ->',
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
                                        builder: (context) => const Loggin()));
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
          ],
        ),
      ]),
    );
  }
}
