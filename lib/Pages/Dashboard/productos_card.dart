import 'package:flutter/material.dart';
import 'package:local_market/Pages/Products/create_products.dart';
import 'package:local_market/Services/button.dart';

class ProductsCard extends StatelessWidget {
  final List<List<String>> products;
  final TextEditingController query;

  const ProductsCard({super.key, required this.products, required this.query});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomField(
            size: 350,
            controller: query,
            label: "Buscar",
            icon: const Icon(Icons.search)),
        const SizedBox(height: 20),
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
        Wrap(
            spacing: 60,
            runSpacing: 50,
            children: products.map((e) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewProducts()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  width: 330,
                  child: Row(
                    children: [
                      SizedBox(
                        child: SizedBox(
                          child: ClipOval(
                            child: e[1] != 'null'
                                ? Image.network(
                                    e[1],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error_outline),
                                  )
                                : Image.network(
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.fill,
                                    e[1],
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.error_outline),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 180,
                        child: Column(
                          children: [
                            Text(
                              e[0],
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              e[4],
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              textAlign: TextAlign.start,
                              "Precio: ${e[3]}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Oferta: ${e[5]}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
      ],
    );
  }
}
