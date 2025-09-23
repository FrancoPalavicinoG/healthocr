import 'dart:io'; // Para manejar archivos locales
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Para seleccionar imagenes
import 'package:http/http.dart' as http; // Para hacer peticiones HTTP
import 'dart:convert'; // Para decodificar JSON
import 'exam_list_screen.dart';

class UploadExamScreen extends StatefulWidget {
    const UploadExamScreen({super.key});

    @override
    State<UploadExamScreen> createState() => _UploadExamScreenState();
}

class _UploadExamScreenState extends State<UploadExamScreen> {
    File ? _selectedImage; // Aqui gurdamos la imagne que seleccione el usuario
    final ImagePicker _picker = ImagePicker(); // Herramienta para abrir la galeria

    // Funcion para abrir la gleria y seleccionar una imagen 
    Future<void> pickImage() async {
        final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
            setState(() {
                _selectedImage = File(pickedFile.path); //Guardamos la imagen seleccionada
            });
        }
    }

    // Funcion para subir imagne seleccionada al backend 
    Future<void> uploadImage() async {
        if (_selectedImage == null) return;
        try {
            var request = http.MultipartRequest(
                'POST', 
                Uri.parse('BASE_URL/api/exams/')
            );

            // Adjuntamos la imagen en el campo "image"
            request.files.add(await http.MultipartFile.fromPath(
                'image', 
                _selectedImage!.path
            ));

            var response = await request.send();

            if (response.statusCode == 200 || response.statusCode == 201) {
                // Extraemos el examId creado para pasarlo como argumento al endpoint de ExamList
                final respStr = await response.stream.bytesToString();
                final respJson = json.decode(respStr);
                final examId = respJson['id'];

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Imagen subida correctamente')),
                );
                
                // Navegamos a ExamList con el examId
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExamListScreen(examId: examId),
                    ),
                );
            } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al subir: ${response.statusCode}')),
                );
            }
        } catch (e) {
            print("Error subiendo imagen: $e");
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $e')),
            );
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text("Subir examen desde galería")),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       // Área visual que muestra la imagen seleccionada o un placeholder
                        _selectedImage == null
                            ? GestureDetector(
                                onTap: pickImage, // Si el usuario toca, abre la galería
                                child: Container(
                                height: 200,
                                width: 200,
                                color: Colors.grey[300],
                                child: const Center(
                                    child: Text("Arrastra o selecciona una imagen"),
                                ),
                                ),
                            )
                            : Image.file(
                                _selectedImage!,
                                height: 200,
                            ),

                        const SizedBox(height: 20), 

                        // Botón para subir la imagen
                        ElevatedButton.icon(
                        onPressed: uploadImage,
                        icon: const Icon(Icons.upload),
                        label: const Text("Subir examen"),
                        ),
                    ],
                ),
            ),
        );
    }
}