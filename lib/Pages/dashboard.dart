import 'package:flutter/material.dart';
import 'package:local_market/State/sesion.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateSesion(),
      child: const Dashboard(),
    ),
  );
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
  final TextEditingController _query = TextEditingController();

  void _userLatestValue() {
    final value = _query.text;
    debugPrint(value);
  }

  @override
  void initState() {
    super.initState();
    _query.addListener(_userLatestValue);
  }

  @override
  void dispose() {
    super.dispose();
    _query.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<StateSesion>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(children: [
                  const SizedBox(width: 18),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(10), // Radio de la esquina
                      child: user.url == ''
                          ? Image.network(
                              'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png')
                          : Image.network(user.url),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name,
                          style: const TextStyle(
                              fontSize: 26,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 1.5),
                          textAlign: TextAlign.start),
                      Text(user.correo,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 1.5),
                          textAlign: TextAlign.start),
                    ],
                  ),
                ]),
                const SizedBox(height: 40),
                SizedBox(
                  width: 330.0,
                  child: TextField(
                    controller: _query,
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    style: const TextStyle(
                      fontSize: 19.0,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text(
                      "Recomendaciones",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        child: const Column(children: [
                          //Realizar una llamada a la api que me devuelva la lista de nogocios en 10klm a la redonda;
                          //Realizar estructura de cada box para negocio tomango en cuenta que se deben ser clicables;
                          //Integrar la API de google maps y hacer referencia a varios puntos en especifico;
                          //Darle mantenimiento a el apartado de preferencia para que redirija al dashboard de buena manera;
                          //Darle desplazamiento a todas las pantallas;
                          //Imagen del nogocio;
                          //Nombre del nogocio;
                        ]),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
