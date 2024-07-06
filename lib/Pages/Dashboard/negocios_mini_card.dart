import 'package:flutter/material.dart';

class NegociosMIniCard extends StatelessWidget {
  final String imagen;
  final String nombre;
  final double width;
  final double heigth;

  ///Este widget proporciona un diseño perzonalizado para mostrar elementos en estilo de cartas
  ///
  ///**imagen**: hace referencia a la imagen de lo que se vaya a renderizar.
  ///
  ///**nombre**: hace referencia al nombre o titulo de lo que se vaya a renderizar.
  ///
  ///**width y height**: hacen referencia a la proporciones de la tarjeta.
  const NegociosMIniCard(
      {super.key,
      required this.imagen,
      required this.nombre,
      required this.width,
      required this.heigth});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 40),
      child: Column(
        children: [
          const SizedBox(width: 20),
          SizedBox(
            width: 100,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Radio de la esquina
              child: imagen == 'null'
                  ? const Image(
                      width: 182,
                      height: 180,
                      fit: BoxFit.cover,
                      image: AssetImage('lib/assets/store.jpeg'))
                  : Image.network(imagen),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            nombre,
            style: const TextStyle(
                fontSize: 15, color: Colors.black, fontFamily: 'Poppins'),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
