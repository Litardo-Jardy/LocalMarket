import 'package:flutter/material.dart';

void main() {
  runApp(const RegisterCliente());
}

class RegisterCliente extends StatelessWidget {
  const RegisterCliente({super.key});

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
  final TextEditingController _name = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _confirPass = TextEditingController();

  void _userLatestValue() {
    final value = _name.text;
    debugPrint(value);
  }

  void _passLatestValue() {
    final value = _pass.text;
    debugPrint(value);
  }

  void _emailLatestValue() {
    final value = _email.text;
    debugPrint(value);
  }

  void _locationLatestValue() {
    final value = _location.text;
    debugPrint(value);
  }

  void _confirPassLatestValue() {
    final value = _confirPass.text;
    debugPrint(value);
  }

  @override
  void initState() {
    super.initState();
    _name.addListener(_userLatestValue);
    _pass.addListener(_passLatestValue);
    _email.addListener(_emailLatestValue);
    _confirPass.addListener(_confirPassLatestValue);
    _location.addListener(_locationLatestValue);
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
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 370,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const SizedBox(
                    width: 390,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Unete como cliente',
                              style: TextStyle(
                                color: Color(0xFFffca7b),
                                fontSize: 37.5,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 2,
                              ),
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(height: 45.0),
                  SizedBox(
                    width: 380,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _name,
                            decoration: InputDecoration(
                              labelText: 'Nombre de usuario',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _email,
                            decoration: InputDecoration(
                              labelText: 'Correo',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: const Icon(Icons.email),
                            ),
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: _location,
                            decoration: InputDecoration(
                              labelText: 'Ubicacion',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: const Icon(Icons.location_city),
                            ),
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          width: 350,
                          child: TextField(
                            controller: _pass,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          width: 350,
                          child: TextField(
                            controller: _confirPass,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        SizedBox(
                          width: 350,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFffca7b),
                              foregroundColor: Colors.black87,
                              shadowColor: Colors.black,
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              minimumSize: const Size(150, 50),
                            ),
                            child: const Text(
                              'Ingresar',
                              style: TextStyle(
                                color: Colors.white, // Texto blanco
                                fontSize: 27.0,
                                letterSpacing: 2,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
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
                                onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
