import 'package:flutter/material.dart';
import 'package:local_market/Pages/Initial/redirection.dart';
import 'dart:ui';

import 'package:local_market/Services/footer.dart';

void main() {
  runApp(const InitialScreen());
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreen();
}

class _InitialScreen extends State<InitialScreen> {
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
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Initial logo;
                  SizedBox(height: 90),
                  Image(width: 310, image: AssetImage('lib/assets/logo.png')),
                  SizedBox(height: 70),

                  //Options
                  CustomButton(
                      route: 1, width: 320, message: 'Unete como cliente'),
                  SizedBox(height: 50),
                  CustomButton(
                      route: 2, width: 320, message: 'Unete como negocio'),
                  SizedBox(height: 30),
                  Text('O',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27.0,
                        letterSpacing: 3,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 30),
                  CustomButton(route: 3, width: 320, message: 'Inicia sesion'),
                ],
              ),
              SizedBox(height: 30.0),
              CustomFooter()
            ],
          ),
        ]));
  }
}
