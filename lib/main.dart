import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crud_firebase/views/add_students.dart';
import 'package:crud_firebase/views/edit_students.dart';
import 'package:crud_firebase/views/home_page.dart';
import 'package:crud_firebase/views/login_page.dart';
import 'package:crud_firebase/views/sign_up_auth.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Firebase',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: "/login",
      routes: {
        "/": (context) => const Home(),
        "/add":(context) => const AddStudents(),
        "/edit":(context) => const EditStudents(),
        "/login":(context) => const LoginPage(),
        "/signup":(context) => const SignUpPage(),
      },
    );
  }
}