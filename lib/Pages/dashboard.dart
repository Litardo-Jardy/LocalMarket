import 'package:flutter/material.dart';
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

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Local Market'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _query = TextEditingController();
  List<List<String>> negocios = [];
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(0, 0);
  final Set<Marker> _markers = {};

  void _userLatestValue() {
    final value = _query.text;
    debugPrint(value);
  }

  @override
  void initState() {
    super.initState();
    _query.addListener(_userLatestValue);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<StateSesion>();
      calculateRange(double.parse(user.latitude), double.parse(user.longitude));
      _initialPosition =
          LatLng(double.parse(user.latitude), double.parse(user.longitude));
      _markers.add(
        Marker(
          markerId: const MarkerId('initialMarker'),
          position: _initialPosition,
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

  @override
  Widget build(BuildContext context) {
    final user = context.watch<StateSesion>();

    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 245, 244, 244),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(children: [
                  const SizedBox(width: 18),
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
                  const SizedBox(width: 20),
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
                const SizedBox(height: 40),
                SizedBox(
                  width: 330.0,
                  child: TextField(
                    controller: _query,
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    style: const TextStyle(
                      fontSize: 19.0,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
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
                const SizedBox(height: 30),
                SingleChildScrollView(
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
                      return Container(
                        margin: const EdgeInsets.only(
                            right: 40), // Espaciado entre elementos
                        child: Column(
                          children: [
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 100,
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10), // Radio de la esquina
                                child: negocio[2] == 'null'
                                    ? const Image(
                                        width: 182,
                                        height: 180,
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage('lib/assets/store.jpeg'))
                                    : Image.network(negocio[2]),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              negocio[0],
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Poppins'),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14,
                    ),
                    markers: _markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
