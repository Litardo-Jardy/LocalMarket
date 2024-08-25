import 'package:flutter/material.dart';

class CheckboxListInput extends StatefulWidget {
  final Function onOptionChage;
  const CheckboxListInput({super.key, required this.onOptionChage});
  @override
  State<CheckboxListInput> createState() => _CheckboxListInputState();
}

class _CheckboxListInputState extends State<CheckboxListInput> {
  // Lista de opciones predefinidas
  final List<String> _opciones = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];

  // Mapa para controlar el estado de los checkboxes
  Map<String, bool> opcionesSeleccionadas = {};

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _opciones.length; i++) {
      opcionesSeleccionadas[_opciones[i]] = false;
    }
  }

  @override
  Widget build(BuildContext conconsttext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: Column(
            children: _opciones.map((opcion) {
              return CheckboxListTile(
                title: Text(opcion),
                value: opcionesSeleccionadas[opcion],
                onChanged: (bool? value) {
                  setState(() {
                    opcionesSeleccionadas[opcion] = value!;
                  });
                  widget.onOptionChage(opcionesSeleccionadas.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .join(' - '));
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
