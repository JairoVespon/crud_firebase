import 'package:flutter/material.dart';
import 'package:crud_firebase/models/crud.dart';

class EditStudents extends StatefulWidget {
const EditStudents({super.key});

@override
State<EditStudents> createState() => _EditStudentsState();
}

class _EditStudentsState extends StatefulWidget {
  final String studentId

  EditStudents(this.studentId);

  @override
  _EditStudentsState createState() => _EditStudentsState();
}

class _EditStudentsState extends State<EditStudents> {
  TextEditingController _nombresControllers = TextEditingController();
  TextEditingController _apellidosControllers = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('tb_students').doc(widget.studentId).get().then((doc) {
      if (doc.exists) {
        var data = doc.data();
        _nombresControllers.text = data?['nombre'];
        _apellidosControllers.text = data!['apellido'].toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Alumno"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Edita los datos del alumno",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nombresControllers,
              decoration: InputDecoration(
                labelText: 'Nombres del alumno',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _apellidosControllers,
              decoration: InputDecoration(
                labelText: 'Apellidos del alumno',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Stock del producto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String newName = nameController.text;
                String newPrice = priceController.text;
                String newStock = stockController.text;

                if (newName.isNotEmpty && newPrice.isNotEmpty && newStock.isNotEmpty) {
                  try {
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    String collectionName = 'tb_productos';

                    double price = double.parse(newPrice);
                    int stock = int.parse(newStock);

                    await firestore.collection(collectionName).doc(widget.productId).update({
                      'nombre': newName,
                      'precio': price,
                      'stock': stock,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Datos Actualizados Correctamente"),
                      ),
                    );

                    Navigator.pop(context); // Regresa a la página anterior después de la edición.
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
              child: Text("Guardar Cambios"),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrumPage extends StatefulWidget {
  const ScrumPage({Key? key}) : super(key: key);

  @override
  _ScrumPageState createState() => _ScrumPageState();
}

class _ScrumPageState extends State<ScrumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Productos"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tb_productos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var productos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              var producto = productos[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    producto['nombre'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Precio: \$${producto['precio'].toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Stock: ${producto['stock']}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarProducto(producto.id),
                        ),
                      );
                    },
                    child: Text("Editar"),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nuevodatos()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
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