import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crud_firebase/views/add_students.dart';
import 'package:crud_firebase/views/home_page.dart';
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
 return MaterialApp(
 debugShowCheckedModeBanner: false,
 title: 'Material App',
 initialRoute: "/",
 routes: {
 "/": (context) => const Home(),
 "/add":(context) => const AddStudents(),
 },
 );
 }
}