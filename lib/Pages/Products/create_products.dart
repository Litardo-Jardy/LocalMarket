import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/productos_card.dart';
import 'package:local_market/Services/button.dart';
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
  final TextEditingController name = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController oferta = TextEditingController();
  final TextEditingController imagen = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    precio.dispose();
    descripcion.dispose();
    oferta.dispose();
    imagen.dispose();
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
                    // CustomField(controller: name, label: "Nombre de producto")
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
