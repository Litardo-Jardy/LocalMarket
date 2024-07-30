import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:local_market/Pages/Products/validation_products.dart';
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
      child: const NewProducts(),
    ),
  );
}

class NewProducts extends StatefulWidget {
  const NewProducts({super.key});

  @override
  State<NewProducts> createState() => _NewProducts();
}

class _NewProducts extends State<NewProducts> {
  final TextEditingController name = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController oferta = TextEditingController();
  final TextEditingController imagen = TextEditingController();
  String image = 'null';
  bool isImagen = false;

  html.File? _imageFile;

  Future<void> setImage(html.File? images, String folder, String id) async {
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
        isImagen = data['request'][0][0];
        image = data['request'][0][1];
      });
    } else {
      final data = json.decode(responseData);
      setState(() {
        isImagen = false;
        image = data['request'][0][1];
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    precio.dispose();
    descripcion.dispose();
    oferta.dispose();
    imagen.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<StateSesion>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 244, 244, 0.867),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Agregar nuevo producto",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 25),
                const Text(
                  "Imagen del producto",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ClipOval(
                  child: image == 'null'
                      ? Image.network(
                          '/home/astrochat/Pictures/Screenshots/hola.png',
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error_outline),
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill)
                      : Image.network(image,
                          width: 300, height: 300, fit: BoxFit.fill),
                ),
                const SizedBox(height: 8),
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
                        setImage(_imageFile, 'Angelito/', user.id.toString());
                      }
                    });
                  },
                  child: const Text('Cargar imagen'),
                ),
                const SizedBox(height: 30),
                CustomField(
                    size: 350,
                    controller: name,
                    label: "Nombre de producto",
                    icon: const Icon(Icons.payment)),
                const SizedBox(height: 30),
                CustomField(
                    size: 350,
                    controller: descripcion,
                    label: "Descripcion de producto",
                    icon: const Icon(Icons.book)),
                const SizedBox(height: 30),
                SizedBox(
                  width: 380,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomField(
                          size: 150,
                          controller: precio,
                          label: "Precio ",
                          icon: const Icon(Icons.book)),
                      CustomField(
                          size: 150,
                          controller: oferta,
                          label: "Oferta",
                          icon: const Icon(Icons.book)),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      validationProducts(
                          name.text,
                          descripcion.text,
                          double.parse(precio.text),
                          oferta.text,
                          image,
                          user.idnegocio,
                          isImagen,
                          context);
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
                      'Crear producto',
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
          )),

          //----Barra de redirecciones;
          Navbar(tipe: user.tipo),
        ],
      ),
    );
  }
}
