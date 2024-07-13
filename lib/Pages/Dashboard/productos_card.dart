import 'package:flutter/material.dart';

class ProductsCard extends StatelessWidget {
  final List<List<String>> products;

  const ProductsCard({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(
              "Productos",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              //redirect to create new products;
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(221, 112, 221, 69),
              elevation: 5,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 23),
              minimumSize: const Size(150, 50),
            ),
            child: const Text(
              "+ Agregar nuevo producto",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                letterSpacing: 1,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        Wrap(
            spacing: 60,
            runSpacing: 50,
            children: products.map((e) {
              return GestureDetector(
                onTap: () {
                  //Funciton for redirect;
                },
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFffca7b),
                          width: 1,
                        ),
                        color: const Color.fromARGB(255, 88, 166, 230),
                        borderRadius: BorderRadius.circular(15),
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
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: e[1] != 'null'
                              ? Image.network(
                                  e[1],
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error_outline),
                                )
                              : Image.network(
                                  'https://img.icons8.com/ios-filled/50/FF8B00/cocktail.png',
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error_outline),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
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
                    const SizedBox(height: 5),
                    Text(
                      e[3],
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
            }).toList()),
      ],
    );
  }
}
