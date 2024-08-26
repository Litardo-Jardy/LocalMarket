import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_market/Pages/Register/api_register_client.dart';
import 'package:local_market/Pages/preferents.dart';

void _registerAndNavigate(String name, String pass, String email,
    String confirPass, String location, context) async {
  try {
    List<String> splitLocation = location.split('|');
    int userId = await registerClient(
        name,
        email,
        double.parse(splitLocation[0]),
        double.parse(splitLocation[1]),
        pass,
        2);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Preferents(usuarioId: userId),
      ),
    );
  } catch (e) {
    debugPrint('Error registering user: $e');
  }
}

///Funcion que aplica los filtros en los inputs para las validaciones antes de crear un usuario nuevo.
///
///**name**: nombre del cliente
///
///**pass**: contraseña del cliente
///
///**email**: email del cliente
///
///**confirPass**: confirmacion de la contraseña
///
///**location**: localizacion
///
///**context**: contexto actual
void validationClient(String name, String pass, String email, String confirPass,
    String location, LatLng position, context) async {
  bool serviceEnabled;

  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  permission = await Geolocator.checkPermission();
  if (name.isEmpty || pass.isEmpty || email.isEmpty || confirPass.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Llene todos los campos'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else if (pass != confirPass) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Las contraseñas no son iguales'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else if (pass.length < 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('La contraseña debe tener al menos 8 caracteres'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else if (name.length < 3) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('El nombre debe tener más de dos caracteres'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
    //Faltan agregar las condiciones si no existe el correo o el nombre ya en la bd;
  } else if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Debe encender la ubicacion para continuar'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permisos de ubicacion denegados'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  } else if (location == "" || location == "null") {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Se deben cargar las cordenadas corretamente'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Te uniste con exito'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );
    _registerAndNavigate(name, pass, email, confirPass,
        "${position.latitude}|${position.longitude}", context);
  }
}
