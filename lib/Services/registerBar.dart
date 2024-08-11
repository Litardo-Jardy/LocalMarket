import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/dashboard_negocio.dart';

class SegmentedButtonExample extends StatefulWidget {
  const SegmentedButtonExample({super.key});

  @override
  State<SegmentedButtonExample> createState() => _SegmentedButtonExampleState();
}

class _SegmentedButtonExampleState extends State<SegmentedButtonExample> {
  String selectPage = "login";

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.red,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.green,
      ),
      segments: const <ButtonSegment<String>>[
        ButtonSegment<String>(
            value: "login",
            label: Text('Login'),
            icon: Icon(Icons.calendar_view_day)),
        ButtonSegment<String>(
            value: "cliente",
            label: Text('CLiente'),
            icon: Icon(Icons.calendar_view_week)),
        ButtonSegment<String>(
            value: "Negocio",
            label: Text('Negocio'),
            icon: Icon(Icons.calendar_view_month)),
      ],
      selected: <String>{selectPage},
      onSelectionChanged: (newSelection) {
        setState(() {
          selectPage = newSelection.first;
        });

        switch (selectPage) {
          case 'Login':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardNegocio()));

            break;
          case 'cliente':
            Navigator.pushNamed(context, '/page1');
            break;
          case 'Negocio':
            Navigator.pushNamed(context, '/page2');
            break;
        }
      },
    );
  }
}
