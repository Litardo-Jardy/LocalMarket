import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:local_market/Pages/Login/login.dart';
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
  List<List<String>> productos = [];
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
    getProductos();
    _query.addListener(_userLatestValue);
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
                            return Container(
                              margin: const EdgeInsets.only(right: 40),
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
                                              image: AssetImage(
                                                  'lib/assets/store.jpeg'))
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
                    SizedBox(
                      height: 330,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(double.parse(user.latitude),
                              double.parse(user.longitude)),
                          zoom: 15,
                        ),
                        markers: _markers,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 360.0,
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
                    const SizedBox(height: 20),
                    //Tarjetas de negocios;
                    Wrap(
                        spacing: 40,
                        runSpacing: 40,
                        children: negocios.map((negocio) {
                          List<List<String>> upProductos =
                              List<List<String>>.from(productos
                                  .where((item) =>
                                      int.parse(item[2]) ==
                                      int.parse(negocio[10]))
                                  .map((item) => List<String>.from(item)));
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 390,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        221, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(children: [
                                    const SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              negocio[0],
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                  letterSpacing: 1.5),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              negocio[8],
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Color(0xFFffca7b),
                                                  fontFamily: 'Poppins',
                                                  letterSpacing: 2),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: 360,
                                      height: 200,
                                      child: negocio[9] != 'null'
                                          ? Image.network(
                                              negocio[9],
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Icon(
                                                      Icons.error_outline),
                                            )
                                          : Image.network(
                                              'https://img.icons8.com/ios-filled/50/FF8B00/cocktail.png',
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Icon(
                                                      Icons.error_outline),
                                            ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: 380,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Text(
                                          negocio[5],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 1),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const SizedBox(
                                      width: 360,
                                      child: Text("Productos destacados:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: 365,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: upProductos.map((producto) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  right: 40),
                                              child: Column(
                                                children: [
                                                  const SizedBox(width: 20),
                                                  SizedBox(
                                                    width: 90,
                                                    height: 110,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), // Radio de la esquina
                                                      child: producto[1] ==
                                                              'null'
                                                          ? const Image(
                                                              width: 162,
                                                              height: 160,
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                  'lib/assets/store.jpeg'))
                                                          : Image.network(
                                                              negocio[2]),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    producto[0],
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
                                    ),
                                    const SizedBox(height: 8),
                                    const SizedBox(
                                      width: 360,
                                      child: Text("Valoracion:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(children: [
                                                Text(
                                                  negocio[11],
                                                  style: const TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.black,
                                                      fontFamily: 'Poppins',
                                                      letterSpacing: 1.5),
                                                ),
                                                const Icon(
                                                  Icons.star_sharp,
                                                  color: Color(0xFFffca7b),
                                                  size: 40,
                                                )
                                              ])),
                                          SizedBox(
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  //Logica para mostrar el negocio completo aqui;
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xFFffca7b),
                                                  foregroundColor:
                                                      Colors.black87,
                                                  shadowColor: Colors.black,
                                                  elevation: 5,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30,
                                                      vertical: 16),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  minimumSize:
                                                      const Size(150, 50),
                                                ),
                                                child: const Text(
                                                  'Ver negocio',
                                                  style: TextStyle(
                                                    color: Colors
                                                        .white, // Texto blanco
                                                    fontSize: 20.0,
                                                    letterSpacing: 2,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ])
                                  ]),
                                ),
                              ]);
                        }).toList()),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              color: const Color(0xFFffca7b),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loggin(),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.home,
                        size: 35,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loggin(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
