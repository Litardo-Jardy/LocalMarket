import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 6, 3, 10)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Local Market'),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Diseño de la parte superior "AppBar"
      appBar: AppBar(
        toolbarHeight: 140.0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            const Icon(
              Icons.my_location, // Icono que deseas mostrar
              color: Color.fromARGB(255, 95, 131, 161),
              size: 75.0,
            ),
            const SizedBox(width: 8.0),
            Container(
              alignment: Alignment.bottomLeft,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 3, 0, 0),
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
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
            Container(
              width: 370,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'Usuario:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 0, 0),
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
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
                  const SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'Contraseña:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 0, 0),
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                      ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
