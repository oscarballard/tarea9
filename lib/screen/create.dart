import 'package:app/db/database.dart';
import 'package:app/model/location.dart';
import 'package:flutter/material.dart';

// Oscar Ballard
class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController dateInput = TextEditingController();
  final myController = TextEditingController();
  final lngController = TextEditingController();
  final latController = TextEditingController();
  late String title;
  late String lat;
  late String lng;

  Future add() async {
    final llamada = Location(
      title: myController.text,
      lat: double.parse(latController.text),
      lng: double.parse(lngController.text),
    );
    await LocationDatabase.instance.create(llamada);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: myController,
              decoration: const InputDecoration(
                  labelText: 'Titulo',
                  prefixIcon: Icon(Icons.title),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: TextStyle(fontSize: 13, color: Colors.blue)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            TextField(
              controller: latController,
              decoration: const InputDecoration(
                  labelText: 'Latitud',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: TextStyle(fontSize: 13, color: Colors.blue)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            TextField(
              controller: lngController,
              decoration: const InputDecoration(
                  labelText: 'Longitud',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: TextStyle(fontSize: 13, color: Colors.blue)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: const Icon(Icons.save),
      ),
    );
  }
}
