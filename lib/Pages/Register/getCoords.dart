import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_market/Services/maps.dart';

class GetCoords extends StatefulWidget {
  final double latitude;
  final double longitude;
  final onTapMaps;
  const GetCoords(
      {super.key,
      required this.latitude,
      required this.onTapMaps,
      required this.longitude});

  @override
  State<GetCoords> createState() => _GetCoords();
}

class _GetCoords extends State<GetCoords> {
  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Haz click en la ubicacion deseada",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Maps(
                latitude: widget.latitude,
                longitude: widget.longitude,
                height: 500,
                onTapMap: widget.onTapMaps,
                onMapCreated: _onMapCreated,
                markers: const {})
          ],
        ));
  }
}
