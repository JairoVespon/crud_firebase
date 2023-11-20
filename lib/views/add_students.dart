import 'package:flutter/material.dart';
import 'package:crud_firebase/models/crud.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  TextEditingController _nombresControllers = TextEditingController(text:"");
  TextEditingController _apellidosControllers = TextEditingController(text:"");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Alumno"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Ingrese sus Nombres",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nombresControllers,
              decoration: InputDecoration(
                labelText: 'Nombre del Estudiante',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _apellidosControllers,
              decoration: InputDecoration(
                labelText: 'Apellidos del Estudiante',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String newNombres = _nombresControllers.text;
                String newApellidos = _apellidosControllers.text;

                if (newNombres.isNotEmpty && newApellidos.isNotEmpty) {
                  try {
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    String collectionName = 'tb_students';

                    String apellidos = (newApellidos);

                    await firestore.collection(collectionName).add({
                      'nombres': newNombres,
                      'apellidos': apellidos,
                    });

                    _nombresControllers.clear();
                    _apellidosControllers.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Datos Agregados Correctamente"),
                      ),
                    );
                  } catch (e) {
                    print("Error: $e");
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Por favor, ingresa todos los datos"),
                    ),
                  );
                }
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}