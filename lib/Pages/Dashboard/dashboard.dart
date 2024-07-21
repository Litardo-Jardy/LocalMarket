import 'package:flutter/material.dart';
import 'package:local_market/Pages/Dashboard/negocios_card.dart';
import 'package:local_market/Pages/Dashboard/negocios_mini_card.dart';
import 'package:local_market/Services/button.dart';
import 'package:local_market/Services/maps.dart';
import 'package:local_market/Services/nav_bar.dart';
import 'package:local_market/State/sesion.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateSesion(),
      child: const Dashboard(),
    ),
  );
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final TextEditingController _query = TextEditingController();
  List<List<String>> negocios = [];
  List<List<String>> productos = [];
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(0, 0);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    getProductos();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<StateSesion>();
      calculateRange(double.parse(user.latitude), double.parse(user.longitude));
      setState(() {
        _initialPosition =
            LatLng(double.parse(user.latitude), double.parse(user.longitude));
      });
      _markers.add(
        Marker(
          markerId: const MarkerId('initialMarker'),
          position:
              LatLng(double.parse(user.latitude), double.parse(user.longitude)),
          infoWindow: const InfoWindow(
            title: 'Tu',
            snippet: 'Esta es tu ubicacion actual.',
          ),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    _query.dispose();
  }

  ///Esta funcion que hace una llamada a la API y devuelve todos los productos almacenados en la base de datos.
  Future<dynamic> getProductos() async {
    final response = await http
        .get(Uri.parse('http://localhost/API_local_market/getProducto.php'));

    final data = json.decode(response.body);
    setState(() {
      productos = List<List<String>>.from(
        data["producto"].map((item) => List<String>.from(item)),
      );
    });
  }

  ///Esta funcion hace una llamada a la API y devuelve una lista de los negocios que se encuentren en el rango definido.
  ///
  ///**nlatitud**: limite norte de la latitud.
  ///
  ///**slatitude**: limite sur de la latitud.
  ///
  ///**nlongitud**:limite oeste de la longitud.
  ///
  ///**slongitud**: limite éste de la longitud.
  Future<dynamic> getNegocios(double nlatitud, double slatitud,
      double nlongitud, double slongitud) async {
    final response = await http.post(
      Uri.parse('http://localhost/API_local_market/getNegocio.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'N_latitude': nlatitud.toString(),
        'S_latitude': slatitud.toString(),
        'N_longitude': nlongitud.toString(),
        'S_longitude': slongitud.toString()
      }),
    );
    try {
      final data = json.decode(response.body);
      List<List<String>> newNegocios = List<List<String>>.from(
        data["negocio"].map((item) => List<String>.from(item)),
      );
      setState(() {
        negocios = newNegocios;
      });
    } catch (e) {
      debugPrint("No se pudieron cargar los negocios. Error: ${e.toString()}");
    }
  }

  ///Esta funcion se encarga de calcular un rango predeterminado sea (5km, 10km, 20km) ala rendonda
  ///tomando como punto de partida [longitude] y [latitude].
  void calculateRange(double latitude, double longitude) {
    int distanceKm = 10;
    int worldRadio = 6371;

    double deltaLat = (distanceKm / worldRadio) * (180 / pi);
    double deltaLong =
        (distanceKm / (worldRadio * cos(latitude * pi / 180))) * (180 / pi);

    double latNorth = latitude + deltaLat;
    double latSouth = latitude - deltaLat;
    double longEast = longitude + deltaLong;
    double longWest = longitude - deltaLong;

    getNegocios(latNorth, latSouth, longEast, longWest);
  }

  ///Esta funcion sirve para agregar mas elementos a lista de _markers.
  void updateMarkers(list) {
    setState(() {
      _markers.add(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<StateSesion>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: Stack(
        children: [
          ListView(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Row(children: [
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10), // Radio de la esquina
                          child: user.url == 'null'
                              ? Image.network(
                                  'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png')
                              : Image.network(user.url),
                        ),
                      ),
                      const SizedBox(width: 17),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name,
                              style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 1.5),
                              textAlign: TextAlign.start),
                          Text(user.correo,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 1.5),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ]),

                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          "Recomendaciones",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 360,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: negocios.map((negocio) {
                            _markers.add(
                              Marker(
                                markerId: MarkerId(negocio[0]),
                                position: LatLng(double.parse(negocio[3]),
                                    double.parse(negocio[4])),
                                infoWindow: InfoWindow(
                                  title: negocio[0],
                                  snippet: negocio[5],
                                ),
                              ),
                            );
                            return NegociosMIniCard(
                                imagen: negocio[2],
                                nombre: negocio[0],
                                width: 100,
                                heigth: 120);
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                        child: Text(
                          "Negocios cerca de ti",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Maps(
                        latitude: double.parse(user.latitude),
                        longitude: double.parse(user.longitude),
                        onMapCreated: _onMapCreated,
                        markers: _markers),

                    const SizedBox(height: 20),

                    CustomField(
                        size: 350,
                        controller: _query,
                        label: "Busacr",
                        icon: const Icon(Icons.search)),

                    const SizedBox(height: 20),

                    //----Tarjetas de negocios;
                    Negocioscard(
                      negocios: negocios,
                      productos: productos,
                    )
                  ],
                ),
              ),
            ],
          ),

          //----Barra de redirecciones;
          Navbar(tipe: user.tipo),
        ],
      ),
    );
  }
}
