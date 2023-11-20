import 'package:flutter/material.dart';
import 'package:crud_firebase/models/crud.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});
  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
final TextEditingController _nombresControllers = TextEditingController(text:"");
final TextEditingController _apellidosControllers = TextEditingController(text:"");

 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: const Text('Agregar Estudiante'),
 ),
 body: Padding(
padding: const EdgeInsets.all(15.0),
 child: Column(
 children: [
 const Text('Datos del Estudiante',
 style: TextStyle(
 fontSize: 30,
 color: Colors.grey,
 fontWeight: FontWeight.bold
 ),
 ),
 const SizedBox(height: 20,),
 TextField(
 controller: _nombresControllers,
 keyboardType: TextInputType.text,
 decoration: const InputDecoration(
 border: OutlineInputBorder(),
 hintText: 'Digite sus nombres',
 prefixIcon: Icon(Icons.person,
 color: Colors.red,)
 ),
 ),
 const SizedBox(height: 20,),
 TextField(
 controller: _apellidosControllers,
 keyboardType: TextInputType.text,
 decoration: const InputDecoration(
 border: OutlineInputBorder(),
 hintText: 'Digite sus apellidos',
 prefixIcon: Icon(Icons.arrow_forward_ios,
 color: Colors.red,)
 ),
 ),
 const SizedBox(height: 20,),
 ElevatedButton(
 onPressed: () async{
 //print('Sus nombres son: ' + _nombresControllers.text);
 //print('Sus apellidos son: ' + _apellidosControllers.text);
 //await addAlumno(_nombresControllers.text, 
_apellidosControllers.text);
 await addAlumno(_nombresControllers.text, 
_apellidosControllers.text).then((_) {
 Navigator.pop(context);
 });
 }, 
 child: const Text('Guardar'))
 ]),
 ),
 );
 }
}