import 'package:flutter/material.dart';
import 'package:local_market/Pages/Login/login.dart';
import 'package:local_market/Pages/Register/api_register_negocio.dart';
import 'package:geolocator/geolocator.dart';

void validationNegocio(
    String name,
    String email,
    String pass,
    String descripcion,
    String referencia,
    String horasApertura,
    String diasApertura,
    String location,
    context,
    selectedItem) {
  if (descripcion.isEmpty ||
      referencia.isEmpty ||
      horasApertura.isEmpty ||
      diasApertura.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Llene todos los campos'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else if (descripcion.length > 300) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('La descripcion excede los caracteres permitidos'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else {
    List<String> splitLocation = location.split('|');
    registerNegocio(
        name,
        pass,
        email,
        double.parse(splitLocation[0]),
        double.parse(splitLocation[1]),
        3,
        referencia,
        horasApertura,
        diasApertura,
        descripcion,
        selectedItem);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Loggin()));
  }
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Te uniste con exito'),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ),
  );
}

void validationPersonNegocio(String name, String email, String pass,
    String confirPass, context, Function updateState) async {
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
  } else {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    updateState("${position.latitude}|${position.longitude}");
  }
}
