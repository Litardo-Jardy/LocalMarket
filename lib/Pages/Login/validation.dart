import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/dashboard_negocio.dart';
import 'package:local_market/Pages/Login/api_validation.dart';
import 'package:local_market/Pages/Dashboard/dashboard.dart';

///Funcion que se encarga de instanciar los datos del usuario en la sesion actual.
///
///**usert**: correo del usuario.
///
///**pass**: contraseña del usuario.
///
///**context**: contexto actual del widget.
///
///**user**: variable de instancia de sesion.
///
void validation(String usert, String pass, context, user) async {
  if (usert.isEmpty || pass.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Llene todos los campos'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  } else {
    List<String> data = await validationUser(usert, pass);

    if (int.parse(data[0]) > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Se accedio con exito'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 3),
        ),
      );

      user.setId(int.parse(data[0]));
      user.setName(data[1]);
      user.setCorreo(data[2]);
      user.setPass(data[3]);
      user.setLatitude(data[4]);
      user.setLongitude(data[5]);
      user.setTipo(int.parse(data[6]));
      user.setUrl(data[7]);
      user.setIdnegocio(int.parse(data[8]));

      if (int.parse(data[6]) == 3) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashboardNegocio()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciales incorrectas'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
