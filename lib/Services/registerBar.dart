import 'package:flutter/material.dart';
import 'package:local_market/Pages/Login/login.dart';
import 'package:local_market/Pages/Register/register_client.dart';
import 'package:local_market/Pages/Register/register_negocio.dart';

class NavigatorRegister extends StatefulWidget {
  final String selectPages;
  const NavigatorRegister({super.key, required this.selectPages});

  @override
  State<NavigatorRegister> createState() => _NavigatorRegisterState();
}

class _NavigatorRegisterState extends State<NavigatorRegister> {
  String selectPage = "login";

  @override
  void initState() {
    super.initState();
    selectPage = widget.selectPages;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: const Color(0xFFffca7b),
      ),
      segments: const <ButtonSegment<String>>[
        ButtonSegment<String>(
            value: "login",
            label: Text('Login',
                style: TextStyle(fontSize: 16, letterSpacing: 1.5)),
            icon: Icon(Icons.login)),
        ButtonSegment<String>(
            value: "cliente",
            label: Text('Cliente',
                style: TextStyle(fontSize: 16, letterSpacing: 1.5)),
            icon: Icon(Icons.person)),
        ButtonSegment<String>(
            value: "negocio",
            label: Text('Negocio',
                style: TextStyle(fontSize: 15.5, letterSpacing: 1.5)),
            icon: Icon(Icons.store)),
      ],
      selected: <String>{selectPage},
      onSelectionChanged: (newSelection) {
        setState(() {
          selectPage = newSelection.first;
        });

        switch (selectPage) {
          case 'login':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Loggin()));
            break;
          case 'cliente':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterCliente()));
            break;
          case 'negocio':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterNegocio()));
            break;
        }
      },
    );
  }
}
