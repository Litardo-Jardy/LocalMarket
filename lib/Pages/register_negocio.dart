import 'package:flutter/material.dart';
import 'package:local_market/Pages/login.dart';

void main() {
  runApp(const RegisterNegocio());
}

class RegisterNegocio extends StatelessWidget {
  const RegisterNegocio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
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
  final TextEditingController _referencia = TextEditingController();
  final TextEditingController _horasApertura = TextEditingController();
  final TextEditingController _diasApertura = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _confirPass = TextEditingController();
  bool isVisible = true;

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

  void _horaAperturaLatestValue() {
    final value = _horasApertura.text;
    debugPrint(value);
  }

  void _diasAperturaLatestValue() {
    final value = _diasApertura.text;
    debugPrint(value);
  }

  void _descripcionLatestValue() {
    final value = _descripcion.text;
    debugPrint(value);
  }

  void _referenciaLatestValue() {
    final value = _referencia.text;
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
    _horasApertura.addListener(_horaAperturaLatestValue);
    _diasApertura.addListener(_diasAperturaLatestValue);
    _descripcion.addListener(_descripcionLatestValue);
    _referencia.addListener(_referenciaLatestValue);
  }

  @override
  void dispose() {
    _name.dispose();
    _pass.dispose();
    _email.dispose();
    _location.dispose();
    _confirPass.dispose();
    _horasApertura.dispose();
    _diasApertura.dispose();
    _descripcion.dispose();
    _referencia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: ListView(
        children: [
          Column(
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
                                'Unete como Negocio',
                                style: TextStyle(
                                  color: Color(0xFFffca7b),
                                  fontSize: 34,
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
                          SingleChildScrollView(
                            child: !isVisible
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: 350.0,
                                        child: TextField(
                                          controller: _referencia,
                                          decoration: InputDecoration(
                                            labelText: 'Referencia',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            prefixIcon: const Icon(Icons.route),
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
                                          controller: _horasApertura,
                                          decoration: InputDecoration(
                                            labelText: 'Horas de apertura',
                                            hintText: "Ejemplo: 9:00 a 18:00",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            prefixIcon: const Icon(Icons.timer),
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
                                          controller: _diasApertura,
                                          decoration: InputDecoration(
                                            labelText: 'Dias de apertura',
                                            hintText:
                                                "Ejemplo: Lunes a Viernes",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            prefixIcon: const Icon(
                                                Icons.calendar_view_day),
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
                                          controller: _descripcion,
                                          decoration: InputDecoration(
                                            labelText: 'Descripcion',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.wordpress),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 50.0),
                                      SizedBox(
                                        width: 350,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFffca7b),
                                            foregroundColor: Colors.black87,
                                            shadowColor: Colors.black,
                                            elevation: 5,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            minimumSize: const Size(150, 50),
                                          ),
                                          child: const Text(
                                            'Unirte',
                                            style: TextStyle(
                                              color:
                                                  Colors.white, // Texto blanco
                                              fontSize: 27.0,
                                              letterSpacing: 2,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                          SingleChildScrollView(
                            child: isVisible
                                ? Column(
                                    children: <Widget>[
                                      const SizedBox(height: 40.0),
                                      SizedBox(
                                        width: 350.0,
                                        child: TextField(
                                          controller: _name,
                                          decoration: InputDecoration(
                                            labelText: 'Nombre de usuario',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.person),
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
                                              borderRadius:
                                                  BorderRadius.circular(35),
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
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.location_city),
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
                                              borderRadius:
                                                  BorderRadius.circular(35),
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
                                              borderRadius:
                                                  BorderRadius.circular(35),
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
                                        child: ElevatedButton(
                                          onPressed: () {
                                            isVisible = !isVisible;
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFffca7b),
                                            foregroundColor: Colors.black87,
                                            shadowColor: Colors.black,
                                            elevation: 5,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            minimumSize: const Size(150, 50),
                                          ),
                                          child: const Text(
                                            'Siguiente ->',
                                            style: TextStyle(
                                              color:
                                                  Colors.white, // Texto blanco
                                              fontSize: 27.0,
                                              letterSpacing: 2,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        ],
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Loggin()));
                            },
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
        ],
      ),
    );
  }
}
