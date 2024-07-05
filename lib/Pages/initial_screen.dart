import 'package:flutter/material.dart';
import 'package:local_market/Pages/register_negocio.dart';

import 'login.dart';
import 'register_client.dart';

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
      body: ListView(
        children: const [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Initial logo;
              SizedBox(height: 90),
              Image(width: 330, image: AssetImage('lib/assets/logo.png')),
              SizedBox(height: 50),

              //Options
              CustomButton(route: 1, width: 370, message: 'Unete como cliente'),
              SizedBox(height: 50),
              CustomButton(route: 2, width: 370, message: 'Unete como negocio'),
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
              CustomButton(route: 3, width: 370, message: 'Iniciar sesion'),
            ],
          ),
        ],
      ),
    );
  }
}

///Esta clase retorna un boton con un diseño pre-definido con valores dinamicos.
///
///**message**: se utiliza para especificar el texto del boton.
///
///**width**: se utiliza para definir el ancho del boton.
///
///**route**: se utiliza para elegir la ruta de destino.
class CustomButton extends StatelessWidget {
  final String message;
  final double width;

  final int route;

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
