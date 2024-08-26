import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon icon;
  final double size;

  ///Inputs perzonalizados.
  ///
  ///**controller**: hace referencia al controlador del input.
  ///
  ///**label**: hace referencia al label del input.
  ///
  ///**icon**: hace referencia al icono del input
  const CustomField(
      {super.key,
      required this.size,
      required this.controller,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          labelText: label,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey, // Color del borde
              width: 1.0, // Grosor del borde
            ),
          ),
          prefixIcon: icon,
        ),
        style: const TextStyle(
          fontSize: 25.0,
        ),
      ),
    );
  }
}
