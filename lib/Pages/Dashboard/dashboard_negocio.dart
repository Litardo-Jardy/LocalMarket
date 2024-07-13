import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/productos_card.dart';
import 'package:local_market/Services/nav_bar.dart';
import 'package:local_market/State/sesion.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateSesion(),
      child: const DashboardNegocio(),
    ),
  );
}

class DashboardNegocio extends StatefulWidget {
  const DashboardNegocio({super.key});

  @override
  State<DashboardNegocio> createState() => _DashboardNegocio();
}

class _DashboardNegocio extends State<DashboardNegocio> {
  final TextEditingController _query = TextEditingController();
  List<List<String>> productos = [];

  @override
  void initState() {
    super.initState();
    getProductos();
  }

  @override
  void dispose() {
    super.dispose();
    _query.dispose();
  }

  ///Esta funcion que hace una llamada a la API y devuelve todos los productos almacenados en la base de datos.
  Future<dynamic> getProductos() async {
    final response = await http
        .get(Uri.parse('http://localhost/API_local_market/getProducto.php'));

    final data = json.decode(response.body);
    setState(() {
      productos = List<List<String>>.from(
        data["producto"].map((item) => List<String>.from(item)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<StateSesion>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: Stack(
        children: [
          ListView(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Row(children: [
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10), // Radio de la esquina
                          child: user.url == 'null'
                              ? Image.network(
                                  'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png')
                              : Image.network(user.url),
                        ),
                      ),
                      const SizedBox(width: 17),
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
                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          "Panel de opciones",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Options(
                              name: "Mi negocio",
                              icon: Icon(Icons.business_sharp)),
                          Options(
                              name: "Mis productos",
                              icon: Icon(Icons.production_quantity_limits)),
                          Options(
                              name: "Mis reservas",
                              icon: Icon(Icons.business_sharp)),
                        ]),
                    const SizedBox(height: 20),
                    ProductsCard(
                        products: List<List<String>>.from(productos
                            .where((item) => int.parse(item[2]) == user.id)
                            .map((item) => List<String>.from(item))),
                        query: _query)
                  ],
                ),
              ),
            ],
          ),

          //----Barra de redirecciones;
          const Navbar(),
        ],
      ),
    );
  }
}

class Options extends StatelessWidget {
  final String name;
  final Icon icon;
  //final Function function;

  const Options({
    super.key,
    required this.name,
    required this.icon,
    //required this.function
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          //Function;
        },
        child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: const Color.fromARGB(255, 40, 125, 223),
                  width: 1,
                ),
                color: const Color.fromARGB(255, 40, 125, 223)),
            child: icon),
      ),
      Text(name)
    ]);
  }
}
