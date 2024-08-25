import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadImageWeb extends StatefulWidget {
  final String id;
  final Function onChangeImage;

  const LoadImageWeb(
      {super.key, required this.id, required this.onChangeImage});

  @override
  State<LoadImageWeb> createState() => _loadImageWeb();
}

class _loadImageWeb extends State<LoadImageWeb> {
  String image = 'null';
  bool isImagen = false;
  html.File? _imageFile;

  String idUser = '';

  @override
  void initState() {
    super.initState;
    idUser = widget.id;
  }

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

  void updateStateImage(bool isImage, String images) {
    setState(() {
      isImagen = isImage;
      image = images;
    });
    widget.onChangeImage(images, isImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 370,
          child: Column(
            children: [
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
                      : Image.network(
                          'https://static.vecteezy.com/system/resources/previews/019/896/008/original/male-user-avatar-icon-in-flat-design-style-person-signs-illustration-png.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        )),
              const SizedBox(height: 13),
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
                      setImage(
                          _imageFile, 'Angelito/', idUser, updateStateImage);
                    }
                  });
                },
                child: const Text('Elegir imagen'),
              ),
            ],
          ),
        )
      ],
    );
  }
}