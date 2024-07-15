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
      child: const NewProducts(),
    ),
  );
}

class NewProducts extends StatefulWidget {
  const NewProducts({super.key});

  @override
  State<NewProducts> createState() => _NewProducts();
}

class _NewProducts extends State<NewProducts> {
  final TextEditingController name = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController oferta = TextEditingController();
  final TextEditingController imagen = TextEditingController();
  String image = '';

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
      backgroundColor: const Color.fromRGBO(245, 244, 244, 0.867),
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Agregar nuevo producto",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      letterSpacing: 1),
                ),
                const SizedBox(width: 40),
                //Colcar codigo para agregar imagen del producto
                const SizedBox(width: 40),
                CustomField(
                    size: 350,
                    controller: name,
                    label: "Nombre de producto",
                    icon: const Icon(Icons.payment)),
                const SizedBox(width: 20),
                CustomField(
                    size: 350,
                    controller: descripcion,
                    label: "Descripcion de producto",
                    icon: const Icon(Icons.book)),
                const SizedBox(width: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomField(
                        size: 150,
                        controller: precio,
                        label: "Precio ",
                        icon: const Icon(Icons.book)),
                    CustomField(
                        size: 150,
                        controller: oferta,
                        label: "Oferta",
                        icon: const Icon(Icons.book)),
                  ],
                ),
                //Colocar validacion de los campos y imagen del nuevo producto
              ],
            ),
          ),

          //----Barra de redirecciones;
          const Navbar(),
        ],
      ),
    );
  }
}
