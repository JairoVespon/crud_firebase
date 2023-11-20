import 'package:flutter/material.dart';
import 'package:crud_firebase/models/crud.dart';

class EditStudents extends StatefulWidget {
const EditStudents({super.key});

@override
State<EditStudents> createState() => _EditStudentsState();
}

class _EditStudentsState extends State<EditStudents> {

final TextEditingController _nombresControllers =
TextEditingController(text: "");
final TextEditingController _apellidosControllers =
TextEditingController(text: "");

@override
Widget build(BuildContext context) {
/*
Aca se reciben los parámetros enviados al dar clic 
en cualquier elemento de la lista. Estos datos se pintan en EditText
*/

final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
_nombresControllers.text = arguments['nombres'];
_apellidosControllers.text = arguments['apellidos'];

return Scaffold(
appBar: AppBar(
  title: const Text('Editando Estudiante'),
),
body: Padding(
padding: const EdgeInsets.all(15.0),
child: Column(
children: [
const Text('Información Estudiante',
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
 //print(arguments["uid"]);
 //await editAlumno("", _nombresControllers.text, 
_apellidosControllers.text);
 await editAlumno(arguments['uid'], 
_nombresControllers.text, _apellidosControllers.text).then((_){
 Navigator.pop(context);
 });
 }, 
 child: const Text('Actualizar'))
 ]),
 ),
 );
 }
 }