import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_market/Pages/Login/login.dart';
import 'package:local_market/Pages/Register/api_register_negocio.dart';

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
bool validationNegocio(
    String descripcion,
    String referencia,
    String horasApertura,
    String diasApertura,
    List<String> images,
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
  } else if (images.length < 2) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Se deben cargar minimo tres images del negocio'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else {
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
    String diasApertura,
    LatLng position,
    String location,
    List<String> images,
    context,
    selectedItem) async {
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
  } else if (location == "" || location == "null") {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Se deben cargar las cordenadas corretamente'),
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
  } else {
    int idNegocio = await registerNegocio(
        name,
        pass,
        email,
        position.latitude,
        position.longitude,
        3,
        referencia,
        horasApertura,
        diasApertura,
        descripcion,
        selectedItem);

    for (var i = 0; i < images.length - 1; i++) {
      addImage(idNegocio, images[i]);
    }

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
