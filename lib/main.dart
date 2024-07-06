import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/dashboard.dart';
import 'State/sesion.dart';
import 'Pages/Login/login.dart';
import 'Pages/Register/register_negocio.dart';
import 'Pages/Register/register_client.dart';
import 'Pages/Initial/initial_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StateSesion()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/Login': (context) => const Loggin(),
          '/ClienteRe': (context) => const RegisterCliente(),
          '/NegocioRe': (context) => const RegisterNegocio(),
          '/Dashboard': (context) => const Dashboard(),
          '/': (context) => const InitialScreen(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4CAF50),
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
