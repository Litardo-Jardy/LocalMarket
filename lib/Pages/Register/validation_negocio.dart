import 'package:flutter/material.dart';
import 'package:local_market/Pages/Login/login.dart';
import 'package:local_market/Pages/Register/api_register_negocio.dart';
import 'package:geolocator/geolocator.dart';

///Funcion que aplica los filtros en los inputs para las validaciones antes de crear un negocio.
///
///Luego de haber pasado todos los filtros esta funcion tambien hace hace una llamada a la API para
///crear el negocio con los datos proporcionados de los inputs.
///
///**name**: nombre del negocio.
///
///**pass**: contraseña del negocio.
///
///**email**: email del negocio.
///
///**descripcion**: descripcion del negocio.
///
///**horasApertura*: horas de apertura del negocio.
///
///**context**: contexto actual.
///
///**diasApertura**: dias de apertura del negocio.
///
///**selectedItem**: categoria del negocio.
bool validationNegocio(String descripcion, String referencia,
    String horasApertura, String diasApertura, context, selectedItem) {
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datos validados con exito'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );
    return true;
  }
  return false;
}

///Funcion que aplica los filtros en los inputs para las validaciones antes de continuar en la creacion de un negocio
///
///**name**: nombre del negocio
///
///**pass**: contraseña del negocio
///
///**email**: email del negocio
///
///**confirPass**: confirmacion de la contraseña
///
///**location**: localizacion del negocio
///
///**context**: contexto actual
///
///**updateState**: funcion que actualizar el estado de la localizacion en el widget principal
void validationPersonNegocio(
  String name,
  String email,
  String pass,
  String confirPass,
  String descripcion,
  String referencia,
  String horasApertura,
  context,
  selectedItem,
  String diasApertura,
) async {
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

    registerNegocio(name, pass, email, position.latitude, position.longitude, 3,
        referencia, horasApertura, diasApertura, descripcion, selectedItem);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Te uniste con exito'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Loggin()));
  }
}
