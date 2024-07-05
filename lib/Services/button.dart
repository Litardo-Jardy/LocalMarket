import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon icon;

  ///Inputs perzonalizados.
  ///
  ///**controller**: hace referencia al controlador del input.
  ///
  ///**label**: hace referencia al label del input.
  ///
  ///**icon**: hace referencia al icono del input
  const CustomField(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          prefixIcon: icon,
        ),
        style: const TextStyle(
          fontSize: 22.0,
        ),
      ),
    );
  }
}
