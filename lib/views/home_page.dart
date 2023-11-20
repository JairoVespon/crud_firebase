import 'package:flutter/material.dart';
import 'package:crud_firebase/models/crud.dart';
class Home extends StatefulWidget {
 const Home({
 super.key,
 });
 @override
 State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
 Null datos;
 void _dataFireBase(){
 db.collection("tb_students").where("first_name", isEqualTo:
"Ana").get().then(
 (querySnapshot) {
 print("Successfully completed");
 for (var docSnapshot in querySnapshot.docs) {
 print('${docSnapshot.id} => ${docSnapshot.data()}');
 }
 },
 onError: (e) => print("Error completing: $e"),
 );
 }
 void _dataFireBase1(){
 setState(() {
 //db = FirebaseFirestore.instance;
 db.collection("tb_students").get().then(
 (querySnapshot) {
 print("Successfully completed");
 for (var docSnapshot in querySnapshot.docs) {
 //datass = docSnapshot.data();
 print('${docSnapshot.id} => ${docSnapshot.data()}');
 }
 },
 onError: (e) => print("Error completing: $e"),
 );
 });
 }
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: const Text('Consulta Cloud Firestore'),
 ),
 body: FutureBuilder(
 future: getAlumno(), 
 builder: ((context, snapshot) {
 if(snapshot.hasData){
 return ListView.builder(
 itemCount: snapshot.data?.length,
 itemBuilder: ((context, index) {
 return Dismissible(
 //Este metodo se ejecuta despues de haber desaparecido el elemento de la pantalla
 onDismissed: (direction) async{
 //Aca va el llamado del metodo que elimina el documento o registro
 //de la base de datos de firebase.
 await deleteAlumno(snapshot.data?[index]['uid']);
 //Eliminando el dato de la memoria del snapshot
 snapshot.data?.removeAt(index);
 setState(() {
 
 });
 },
 //Este metodo se ejectua 
 confirmDismiss: (direction) async{
 //print('Confirmacion de Dismissible');
 bool result = false;
 result = await showDialog(
 context: context, 
 builder: (context){
 return AlertDialog(
 title: Text("¿Realmente desea eliminar a 
${snapshot.data?[index]['first_name']}
${snapshot.data?[index]['seconds_name']}?"),
 actions: [
 TextButton(
 onPressed: (){
 Navigator.pop(context, false);
 }, 
child: const Text("Cancelar", style: TextStyle(
 fontSize: 14,
 fontWeight: FontWeight.bold,
 color: Colors.amber
 ),)),
TextButton(
onPressed: (){
 Navigator.pop(context, true);
 }, 
child: const Text("Aceptar"))
 ],
 ));
 });
 return result;
 },
 background: Container( 
 color: Colors.red,
 child: const Icon(Icons.delete),
 ),
 //key: UniqueKey(),
 key: Key(snapshot.data?[index]['uid']),
 direction: DismissDirection.endToStart,
 child: Card(
 elevation: 10,
 clipBehavior: Clip.hardEdge,
 shape: const RoundedRectangleBorder(
 side: BorderSide(
 //color: Theme.of(context).colorScheme.outline,
 color: Colors.black,
 ),
borderRadius: BorderRadius.all(Radius.circular(12)),
 ),
child: InkWell(
 //splashColor: Colors.blue.withAlpha(30),
splashColor: Colors.grey,
onTap: () async{
 //debugPrint(snapshot.data?[index]['first_name'] + " " + snapshot.data?[index]['seconds_name']);
 await Navigator.pushNamed(context, "/edit", 
arguments: {
 'uid' : snapshot.data?[index]['uid'],
 'nombres' : snapshot.data?[index]['first_name'],
 'apellidos' : snapshot.data?[index]['seconds_name']
 });
 setState(() {
 
 });
 },
child: SizedBox(
 width: 300,
 height: 100,
 child: Center(
 child: Text(
 snapshot.data?[index]['first_name'] + " " +
snapshot.data?[index]['seconds_name'],
 style: const TextStyle(
 fontSize: 20,
 fontWeight: FontWeight.bold,
 color: Colors.blue
 ),
 ),
 ),
 ),
 ),
 ),
 );
 }),
 );
 }else{
 return const Center(
 child: CircularProgressIndicator(),
 );
 } 
 })
 ),
 floatingActionButton: FloatingActionButton(onPressed: () async{
 await Navigator.pushNamed(context, "/add");
 setState(() {
 
 });
 //print('Termino la espera');
 },
child: const Icon(Icons.add),
 ),
 );
 }
}