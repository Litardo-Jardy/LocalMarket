import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/dashboard.dart';
import 'package:local_market/Pages/Dashboard/dashboard_negocio.dart';
import 'package:local_market/Pages/Profile/profile_card_client.dart';
import 'package:local_market/Pages/Profile/profile_card_negocio.dart';
import 'package:local_market/Pages/Login/login.dart';
import 'package:local_market/Pages/Products/create_products.dart';

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
                  Icons.shopping_cart_outlined,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.person_2_outlined,
                  size: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  tipe == 3
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileEdit(),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileEditClient(),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.add_shopping_cart,
                  size: 35,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  tipe == 3
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewProducts(),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.exit_to_app_outlined,
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
          ],
        ),
      ),
    );
  }
}
