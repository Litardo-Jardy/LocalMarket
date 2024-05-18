import 'package:flutter/material.dart';

void main() {
  runApp(const Loggin());
}

class Loggin extends StatelessWidget {
  const Loggin({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 6, 3, 10),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Local Market'),
      debugShowCheckedModeBanner:
          false, // Eliminar la marca de verificación de depuración
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
    _pass.dispose(); // Asegúrate de disponer del controlador _pass también
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 170.0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            const SizedBox(height: 20.0),
            const Icon(
              Icons.place, // Icono que deseas mostrar
              color: Color.fromARGB(255, 47, 83, 182),
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
                    color: Color.fromARGB(255, 3, 0, 0),
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
                      color: Color.fromARGB(255, 3, 0, 0),
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'Usuario:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 0, 0),
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(height: 17.0),
                  TextField(
                    controller: _user,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese su usuario',
                    ),
                  ),
                  const SizedBox(height: 45.0),
                  const Text(
                    'Contraseña:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 0, 0),
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  const SizedBox(height: 17.0),
                  TextField(
                    controller: _pass,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese su contraseña',
                    ),
                  ),
                  const SizedBox(height: 45.0),
                  SizedBox(
                    width: 370,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 68, 243, 33),
                        foregroundColor: const Color.fromARGB(255, 43, 109, 13),
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
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 27.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        side: const BorderSide(color: Colors.white, width: 0),
                      ),
                      child: const Text(
                        '¿No tienes cuenta? Registrate aquí',
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
