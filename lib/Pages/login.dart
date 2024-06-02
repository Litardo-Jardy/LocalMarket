import 'package:flutter/material.dart';

void main() {
  runApp(const Loggin());
}

class Loggin extends StatelessWidget {
  const Loggin({super.key});

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
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  void _userLatestValue() {
    final value = _user.text;
    debugPrint(value);
  }

  void _passLatestValue() {
    final value = _pass.text;
    debugPrint(value);
  }

  @override
  void initState() {
    super.initState();
    _user.addListener(_userLatestValue);
    _pass.addListener(_passLatestValue);
  }

  @override
  void dispose() {
    _user.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 370,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 370,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                              width: 250,
                              image: AssetImage('lib/assets/logo.png')),
                          Align(
                            alignment: Alignment
                                .bottomCenter, // Puedes ajustar esto según tus necesidades
                            child: Text(
                              'Iniciar Sesion',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 38.0,
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
                            controller: _user,
                            decoration: InputDecoration(
                              labelText: 'Usuario',
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
                        const SizedBox(height: 45.0),
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
                        const SizedBox(height: 50.0),
                        SizedBox(
                          width: 350,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20.0),
                              const Text(
                                '¿No tienes cuenta?',
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
                                  'Regístrate aquí',
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
