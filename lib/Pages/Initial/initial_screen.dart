import 'package:flutter/material.dart';
import 'package:local_market/Pages/Initial/redirection.dart';

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
          SizedBox(height: 30.0),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              '© 2024 AstroChat. Todos los derechos reservados.',
              style: TextStyle(color: Color.fromARGB(255, 182, 181, 181)),
            ),
          ),
        ],
      ),
    );
  }
}
