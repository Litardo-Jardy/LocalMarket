import 'package:flutter/material.dart';

class StateSesion with ChangeNotifier {
  int _id = 0;
  int _tipo = 0;
  int _idnegocio = 0;
  String _name = '';
  String _correo = '';
  String _pass = '';
  String _url = '';
  String _longitude = '';
  String _latitude = '';

  int get id => _id;
  int get tipo => _tipo;
  int get idnegocio => _idnegocio;
  String get name => _name;
  String get correo => _correo;
  String get url => _url;
  String get longitude => _longitude;
  String get latitude => _latitude;
  String get pass => _pass;

  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  void setPass(String pass) {
    _pass = pass;
    notifyListeners();
  }

  void setTipo(int tipo) {
    _tipo = tipo;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setCorreo(String correo) {
    _correo = correo;
    notifyListeners();
  }

  void setUrl(String url) {
    _url = url;
    notifyListeners();
  }

  void setLongitude(String longitude) {
    _longitude = longitude;
    notifyListeners();
  }

  void setLatitude(String latitude) {
    _latitude = latitude;
    notifyListeners();
  }

  void setIdnegocio(int id) {
    _idnegocio = id;
    notifyListeners();
  }
}
