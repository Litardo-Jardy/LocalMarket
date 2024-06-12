import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<String>? _items;
  List<String> selects = [];

  @override
  void initState() {
    super.initState();
    categorys();
  }

  @override
  void dispose() {
    super.dispose();
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
                const Text(
                  "Selecciona tus preferencias",
                  style: TextStyle(
                    color: Color(0xFFffca7b),
                    fontSize: 37.5,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Wrap(
                  spacing: 50,
                  runSpacing: 50,
                  children: _items?.map((e) {
                        bool isSelected = selects.contains(e);
                        return GestureDetector(
                          onTap: () {
                            onItemPressed(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Te uniste con éxito'),
                                backgroundColor: Colors.blue,
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                          child: Container(
                            width: 130,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFffca7b),
                                width: 2,
                              ),
                              color: isSelected
                                  ? Colors.green
                                  : const Color(0xFFffca7b),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                e,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
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
                  onPressed: () {
                    for (var i = 0; i < selects.length; i++) {
                      addPreferens(selects[i]);
                    }
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
