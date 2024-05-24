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
      appBar: AppBar(
        toolbarHeight: 170.0,
        backgroundColor: const Color(0xFFF2F2F2), // Fondo gris claro
        title: Row(
          children: [
            const SizedBox(height: 20.0),
            const Icon(
              Icons.place,
              color: Color(0xFF4CAF50), // Icono verde
              size: 90.0,
            ),
            const SizedBox(width: 5.0),
            const SizedBox(height: 20.0),
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.black87, // Texto negro
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 370,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Iniciar sesion',
                    style: TextStyle(
                      color: Colors.black87, // Texto negro
                      fontSize: 45.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 45.0),
                  const Text(
                    'Usuario:',
                    style: TextStyle(
                      color: Colors.black54, // Texto gris oscuro
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(height: 17.0),
                  TextField(
                    controller: _user,
                    decoration: const InputDecoration(
                      hintText: 'Ingrese su usuario',
                    ),
                    style: const TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(height: 45.0),
                  const Text(
                    'Contraseña:',
                    style: TextStyle(
                      color: Colors.black54, // Texto gris oscuro
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(height: 17.0),
                  TextField(
                    controller: _pass,
                    decoration: const InputDecoration(
                      hintText: 'Ingrese su contraseña',
                    ),
                  ),
                  const SizedBox(height: 45.0),
                  SizedBox(
                    width: 370,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFFF9800), // Botón naranja
                        foregroundColor: Colors.black87, // Texto negro
                        shadowColor: Colors.black,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(150, 50),
                        side: const BorderSide(color: Colors.black, width: 2),
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
                  const SizedBox(height: 60.0),
                  SizedBox(
                    width: 400,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        '¿No tienes cuenta? Regístrate aquí',
                        style: TextStyle(
                          color: Color.fromARGB(255, 47, 83, 182),
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
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
