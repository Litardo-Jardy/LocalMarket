import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget {
  final double latitude;
  final double longitude;
  final Set<Marker> markers;
  final onMapCreated;

  ///Esta funcion renderiza un mapa usando la API de google maps.
  ///
  ///**latitude**: hace referencia al valor de latitude para el marker inicial.
  ///
  ///**longitude**: hace referencia al valor de longitud para el marker inicial.
  ///
  ///**onMapCreated**: hace referencia al controlador del mapa.
  ///
  ///**markers**: hace referencia a una lista de marcadores para colocar en el mapa una vez renderizado.
  const Maps(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.onMapCreated,
      required this.markers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
