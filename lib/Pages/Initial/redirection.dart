import 'package:flutter/material.dart';
import 'package:local_market/Pages/Register/register_negocio.dart';

import '../Login/login.dart';
import '../Register/register_client.dart';

class CustomButton extends StatelessWidget {
  final String message;
  final double width;

  final int route;

  ///Esta clase retorna un boton con un diseño pre-definido con valores dinamicos.
  ///
  ///**message**: se utiliza para especificar el texto del boton.
  ///
  ///**width**: se utiliza para definir el ancho del boton.
  ///
  ///**route**: se utiliza para elegir la ruta de destino.
  const CustomButton(
      {super.key,
      required this.route,
      required this.width,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          switch (route) {
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterCliente()));
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterNegocio()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Loggin()));
              break;
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFffca7b),
          foregroundColor: const Color.fromARGB(221, 255, 255, 255),
          shadowColor: Colors.black,
          elevation: 5,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 23),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          minimumSize: const Size(150, 50),
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            letterSpacing: 1,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
