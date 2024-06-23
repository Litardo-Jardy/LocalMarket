import 'package:flutter/material.dart';
import 'package:local_market/Pages/register_negocio.dart';
import 'login.dart';
import 'register_client.dart';

void main() {
  runApp(const InitialScreen());
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50), // Semilla de color verde vibrante
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Local Market'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              const Image(width: 330, image: AssetImage('lib/assets/logo.png')),
              const SizedBox(height: 50),
              SizedBox(
                width: 370,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterCliente()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFffca7b),
                    foregroundColor: const Color.fromARGB(221, 255, 255, 255),
                    shadowColor: Colors.black,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Unirse como cliente',
                    style: TextStyle(
                      color: Colors.white, // Texto blanco
                      fontSize: 25.0,
                      letterSpacing: 1,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 370,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterNegocio(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFffca7b),
                    foregroundColor: Colors.black87,
                    shadowColor: Colors.black,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Unirse como negocio',
                    style: TextStyle(
                      color: Colors.white, // Texto blanco
                      fontSize: 25.0,
                      letterSpacing: 1,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text('O',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 27.0,
                    letterSpacing: 3,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 30),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Loggin()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFffca7b),
                    foregroundColor: Colors.black87,
                    shadowColor: Colors.black,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Iniciar sesion',
                    style: TextStyle(
                      color: Colors.white, // Texto blanco
                      fontSize: 25.0,
                      letterSpacing: 1,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
