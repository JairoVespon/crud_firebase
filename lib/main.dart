import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crud_firebase/models/crud.dart';
import 'firebase_options.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MyApp());
}
//void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
 return const MaterialApp(
 debugShowCheckedModeBanner: false,
 title: 'Material App',
 home: Home()
 );
 }
}
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
 future: getStudiantes(), 
 builder: ((context, snapshot) {
 return ListView.builder(
 itemCount: snapshot.data?.length,
 itemBuilder: ((context, index) {
 //datos = snapshot.data?[index]['first_name'];
 return Card(
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
 onTap: () {
 debugPrint(snapshot.data?[index]['first_name'] + " " +
snapshot.data?[index]['seconds_name']);
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
 );
 }),
 );
 })
 ),
 );
 }
}