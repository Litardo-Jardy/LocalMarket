import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/negocios_mini_card.dart';

class Negocioscard extends StatelessWidget {
  final List<List<String>> negocios;
  final List<List<String>> productos;

  ///Esta funcion proporciona un widget con un diseño para renderizar negocios en forma de Cards.
  ///
  ///**negocios**: hace referencia aun valor List<List<String>> que se encargara de proporcionar los negocios para renderizar las cards.
  ///
  ///**productos**: hace referencia aun valor List<List<String>> que se encargara de proporcionar los diferentes productos de negocios segun corresponda.
  const Negocioscard(
      {super.key, required this.negocios, required this.productos});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 40,
        runSpacing: 40,
        children: negocios.map((negocio) {
          List<List<String>> upProductos = List<List<String>>.from(productos
              .where((item) => int.parse(item[2]) == int.parse(negocio[10]))
              .map((item) => List<String>.from(item)));

          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 390,
              decoration: BoxDecoration(
                color: const Color.fromARGB(221, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(children: [
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          negocio[0],
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              letterSpacing: 1.5),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          negocio[8],
                          style: const TextStyle(
                              fontSize: 17,
                              color: Color(0xFFffca7b),
                              fontFamily: 'Poppins',
                              letterSpacing: 2),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 360,
                  height: 200,
                  child: negocio[9] != 'null'
                      ? Image.network(
                          negocio[9],
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error_outline),
                        )
                      : Image.network(
                          'https://img.icons8.com/ios-filled/50/FF8B00/cocktail.png',
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error_outline),
                        ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 380,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      negocio[5],
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          letterSpacing: 1),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 360,
                  child: Text("Productos destacados:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 365,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: upProductos.map((producto) {
                        return NegociosMIniCard(
                            heigth: 110,
                            width: 90,
                            nombre: producto[0],
                            imagen: producto[1]);
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 360,
                  child: Text("Valoracion:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(children: [
                            Text(
                              negocio[11],
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 1.5),
                            ),
                            const Icon(
                              Icons.star_sharp,
                              color: Color(0xFFffca7b),
                              size: 40,
                            )
                          ])),
                      SizedBox(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () {
                              //Logica para mostrar el negocio completo aqui;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFffca7b),
                              foregroundColor: Colors.black87,
                              shadowColor: Colors.black,
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(150, 50),
                            ),
                            child: const Text(
                              'Ver negocio',
                              style: TextStyle(
                                color: Colors.white, // Texto blanco
                                fontSize: 20.0,
                                letterSpacing: 2,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])
              ]),
            ),
          ]);
        }).toList());
  }
}
