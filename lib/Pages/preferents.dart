import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:local_market/State/sesion.dart';
import 'package:provider/provider.dart';

import 'package:local_market/Pages/dashboard.dart';

Future<dynamic> validationUser(int id) async {
  final response = await http.post(
    Uri.parse('http://localhost/API_local_market/getUser.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'user': 'null', 'pass': 'pass', 'id': id.toString()}),
  );

  try {
    final data = json.decode(response.body);
    List<String> result = List<String>.from(data["user"][0]);
    return result;
  } catch (e) {
    debugPrint("No se pudieron cargar los datos. Error: ${e.toString()}");
    return [];
  }
}

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
  List<List<String>>? _items;
  List<List<String>>? _itemsTwo;
  List<String> selects = [];

  void _userLatestValue() {
    final value = _query.text;
    if (value.length > 1) {
      setState(() {
        _items = List<List<String>>.from(_items!
            .where((item) => item[0].contains(value))
            .map((item) => List<String>.from(item)));
      });
    } else {
      setState(() {
        _items = _itemsTwo;
      });
    }
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
            _items = List<List<String>>.from(
                data['categorys'].map((item) => List<String>.from(item)));

            _itemsTwo = List<List<String>>.from(
                data['categorys'].map((item) => List<String>.from(item)));
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
    final user = context.watch<StateSesion>();
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
                              bool isSelected = selects.contains(e[0]);
                              return GestureDetector(
                                onTap: () {
                                  onItemPressed(e[0]);
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
                                            : const Color.fromARGB(
                                                221, 245, 244, 244),
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
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: e[1] != 'null'
                                              ? Image.network(
                                                  e[1],
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(
                                                          Icons.error_outline),
                                                )
                                              : Image.network(
                                                  'https://img.icons8.com/ios-filled/50/FF8B00/cocktail.png',
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(
                                                          Icons.error_outline),
                                                ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      e[0],
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
                    backgroundColor: Color(0xFFFF8B00),
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
                  onPressed: () async {
                    for (var i = 0; i < selects.length; i++) {
                      addPreferens(selects[i]);
                    }

                    List<String> data = await validationUser(widget.usuarioId);

                    if (data.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Se accedio con exito'),
                          backgroundColor: Colors.blue,
                          duration: Duration(seconds: 3),
                        ),
                      );

                      user.setId(int.parse(data[0]));
                      user.setName(data[1]);
                      user.setCorreo(data[2]);
                      user.setPass(data[3]);
                      user.setLatitude(data[4]);
                      user.setLongitude(data[5]);
                      user.setTipo(int.parse(data[6]));
                      user.setUrl(data[7]);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ));
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
