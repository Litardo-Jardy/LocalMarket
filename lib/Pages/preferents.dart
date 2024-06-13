import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:local_market/Pages/dashboard.dart';

class Preferents extends StatelessWidget {
  final int usuarioId;

  const Preferents({super.key, required this.usuarioId});

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
      home: MyHomePage(title: 'Preferencias', usuarioId: usuarioId),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.usuarioId});

  final String title;
  final int usuarioId;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _query = TextEditingController();
  List<String>? _items;
  List<String> selects = [];

  void _userLatestValue() {
    final value = _query.text;
    debugPrint(value);
  }

  @override
  void initState() {
    super.initState();
    _query.addListener(_userLatestValue);
    categorys();
  }

  @override
  void dispose() {
    super.dispose();
    _query.dispose();
  }

  Future<void> categorys() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost/API_local_market/getCategorys.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['categorys'] != null && data['categorys'] is List) {
          setState(() {
            _items = List<String>.from(
                data['categorys'].map((item) => item[0] as String));
          });
        } else {
          throw Exception('Error al mostrar los datos');
        }
      } else {
        throw Exception('Error en la petición: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("No se pudo ${e.toString()}");
    }
  }

  void onItemPressed(String item) {
    setState(() {
      if (selects.contains(item)) {
        selects.remove(item);
      } else {
        selects.add(item);
      }
    });
  }

  Future<dynamic> addPreferens(String categoria) async {
    await http.post(
        Uri.parse('http://localhost/API_local_market/addPreferents.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          'categoria': categoria,
          'persona': widget.usuarioId.toString(),
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 380.0,
                        child: Text(
                          "Elige 3 o mas negocios de tu preferencia.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 5, 5, 5),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 380.0,
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
                      Wrap(
                        spacing: 60,
                        runSpacing: 50,
                        children: _items?.map((e) {
                              bool isSelected = selects.contains(e);
                              return GestureDetector(
                                onTap: () {
                                  onItemPressed(e);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFffca7b),
                                          width: 1,
                                        ),
                                        color: isSelected
                                            ? Colors.green
                                            : const Color(0xFFffca7b),
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                          child: Icon(
                                              Icons.shopping_bag_outlined)),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      e,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList() ??
                            [],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: SizedBox(
                width: 380,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 214, 162, 84),
                    foregroundColor: Colors.black87,
                    shadowColor: Colors.black,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  onPressed: () {
                    for (var i = 0; i < selects.length; i++) {
                      addPreferens(selects[i]);
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Dashboard(),
                        ));
                  },
                  child: Text(
                    'Seleccionar (${selects.length})',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 254, 252),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
