import 'package:flutter/material.dart'; // Importa el core de Flutter para UI
import 'dart:convert'; // Para decodificar JSON
import 'package:http/http.dart' as http; // Para hacer peticiones HTTP

// Importa la pantalla de la cámara
import 'upload_exam_screen.dart';

// Clase principal del screen de exámenes
class ExamListScreen extends StatefulWidget {
  const ExamListScreen({super.key});

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

// Estado del screen, donde vive la lógica y datos
class _ExamListScreenState extends State<ExamListScreen> {
    late Future<List<dynamic>> exams; // Variable que almacenará la lista de resultados futuros

    @override
    void initState() {
        super.initState();
        exams = fetchExams(); // Al iniciar, hacemos la petición a la API
    }

    // Función que hace el GET a la API y devuelve la lista de resultados
    Future<List<dynamic>> fetchExams() async {
        // Se construye la URL de la API
        final response = await http.get(Uri.parse('BASE_URL/api/exams/33'));

        if (response.statusCode == 200) {
            // Si la respuesta es correcta, decodificamos el JSON
            final data = jsonDecode(response.body);
            return data['results']; // Retornamos solo la losta de los resultados
        } else {
            // Lanzamos error
            throw Exception('Failed to load exams');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            // AppBar superior con titulo
            appBar: AppBar(
                title: const Text('Examenes'),
            ),
            // Body principal del screen
            body: FutureBuilder<List<dynamic>>(
                future: exams, // Indicamos la futura data que estamos esperando
                builder: (context, snapshot) {
                    // Mientras espermaos la respuesta
                    if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator()); // Spinner
                    }
                    // Si ocurre un error en la peticion
                    else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    // Si no hay datos
                    else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No hay exámenes'));
                    }

                    // Si tenemos datos, los guradamos en una variable
                    final examResults = snapshot.data!;

                    // Construimos la lista de cards
                    return ListView.builder(
                        itemCount: examResults.length, // Numero de items de la lista
                        itemBuilder: (context, index) {
                            final exam = examResults[index];
                            return Card(
                                margin: const EdgeInsets.all(8),
                                child: ListTile(
                                    // Nombre del test
                                    title: Text(exam['test_name']),
                                    // Resultado y rango de referencia
                                    subtitle: Text(
                                        'Resultado: ${exam['result']} ${exam['unit']}\n'
                                        'Referencia: ${exam['reference_range']}',
                                    ),
                                ),
                            );
                        },
                    );
                },
            ),
            // Boton para ir al upload exam 
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UploadExamScreen()), // Navega al screen de upload exam
                    );
                },
                child: const Icon(Icons.camera_alt), // Icono de cámara
            ),
        );
    }
}