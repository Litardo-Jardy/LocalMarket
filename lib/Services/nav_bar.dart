import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/dashboard.dart';
import 'package:local_market/Pages/Dashboard/dashboard_negocio.dart';
import 'package:local_market/Pages/Login/login.dart';

class Navbar extends StatelessWidget {
  final int tipe;

  ///Navbar que permite la redireccion hacia a las diferentes secciones de la aplicacion.
  const Navbar({super.key, required this.tipe});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        color: const Color(0xFFffca7b),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Loggin(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.home,
                  size: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  tipe == 3
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardNegocio(),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
