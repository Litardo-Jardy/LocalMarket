import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:local_market/Services/button.dart';
import 'package:local_market/Services/nav_bar.dart';
import 'package:local_market/State/sesion.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateSesion(),
      child: const MaterialApp(
        home: ProfileEditClient(),
      ),
    ),
  );
}

class ProfileEditClient extends StatefulWidget {
  const ProfileEditClient({super.key});

  @override
  State<ProfileEditClient> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEditClient> {
  final TextEditingController name = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController latitude = TextEditingController();
  final TextEditingController longitude = TextEditingController();

  List<List<String>> negocio = [];

  String image = 'null';
  bool isImagen = false;
  html.File? _imageFile;

  Future<void> setImage(
      html.File? images, String folder, String id, Function updateState) async {
    final uri = Uri.parse('http://localhost/SkyLocal/setImage.php');
    var request = http.MultipartRequest('POST', uri);

    request.fields['Folder'] = folder;
    request.fields['id'] = id;

    var reader = html.FileReader();
    reader.readAsArrayBuffer(images as html.Blob);
    await reader.onLoad.first;

    var imageData = reader.result as Uint8List;
    request.files.add(http.MultipartFile.fromBytes(
      'Image',
      imageData,
      filename: images?.name,
    ));

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = json.decode(responseData);
      setState(() {
        updateState(data['request'][0][0], data['request'][0][1]);
      });
    } else {
      final data = json.decode(responseData);
      setState(() {
        updateState(false, data['request'][0][1]);
      });
    }
  }

  void updateStateImage(bool isimage, String images) {
    setState(() {
      isImagen = isimage;
      image = images;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = context.read<StateSesion>();
      setState(() {
        name.text = user.name;
        correo.text = user.correo;
        pass.text = user.pass;
        latitude.text = user.latitude;
        longitude.text = user.longitude;
      });
    });
  }

  @override
  void dispose() {
    name.dispose();
    correo.dispose();
    pass.dispose();
    latitude.dispose();
    longitude.dispose();
    super.dispose();
  }

  Future<dynamic> updateUser(String nombres, String correo, String imagen,
      String passs, int id, String longitude, String latitude) async {
    final response = await http.post(
      Uri.parse('http://localhost/API_local_market/updateUser.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': nombres,
        'email': correo,
        'imagen': imagen,
        'pass': passs,
        'id': id.toString(),
        'latitude': latitude.toString(),
        'longitude': longitude.toString()
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<StateSesion>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 244, 244, 0.867),
      body: Stack(
        children: [
          Expanded(
            child: ListView(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35.0),
                          child: Text(
                            "Informacion del negocio",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Imagen de perfil",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ClipOval(
                        child: (image != 'null' && image.isNotEmpty)
                            ? Image.network(
                                image,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error_outline),
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              )
                            : (user.url != null && user.url!.isNotEmpty)
                                ? Image.network(
                                    user.url!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  )
                                : const Icon(Icons.person, size: 200),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          html.FileUploadInputElement uploadInput =
                              html.FileUploadInputElement();
                          uploadInput.accept = 'image/*';
                          uploadInput.click();

                          uploadInput.onChange.listen((e) {
                            final files = uploadInput.files;
                            if (files!.isNotEmpty) {
                              setState(() {
                                _imageFile = files.first;
                              });
                              setImage(_imageFile, 'Angelito/',
                                  user.id.toString(), updateStateImage);
                            }
                          });
                        },
                        child: const Text('Cambiar imagen'),
                      ),
                      const SizedBox(height: 20),
                      CustomField(
                          size: 350,
                          controller: name,
                          label: "Nombre",
                          icon: const Icon(Icons.payment)),
                      const SizedBox(height: 30),
                      CustomField(
                          size: 350,
                          controller: correo,
                          label: "Correo",
                          icon: const Icon(Icons.book)),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 380,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomField(
                                size: 150,
                                controller: latitude,
                                label: "Latitud",
                                icon: const Icon(Icons.book)),
                            CustomField(
                                size: 150,
                                controller: longitude,
                                label: "Longitud",
                                icon: const Icon(Icons.book)),
                          ],
                        ),
                      ),
                      CustomField(
                          size: 350,
                          controller: pass,
                          label: "Contraseña",
                          icon: const Icon(Icons.book)),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: 350,
                        child: ElevatedButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Se actualizaron los datos con exito.'),
                                backgroundColor: Colors.blue,
                                duration: Duration(seconds: 3),
                              ),
                            );
                            await updateUser(
                                name.text,
                                correo.text,
                                image,
                                pass.text,
                                user.id,
                                longitude.text,
                                latitude.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileEditClient()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFffca7b),
                            foregroundColor: Colors.black87,
                            shadowColor: Colors.black,
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            minimumSize: const Size(150, 50),
                          ),
                          child: const Text(
                            'Actualizar datos',
                            style: TextStyle(
                              color: Colors.white, // Texto blanco
                              fontSize: 27.0,
                              letterSpacing: 2,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Navbar(tipe: user.tipo),
        ],
      ),
    );
  }
}
