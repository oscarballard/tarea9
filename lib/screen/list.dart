import 'package:app/db/database.dart';
import 'package:app/model/location.dart';
import 'package:flutter/material.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  late List<Location> llamadas;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    llamadas = await LocationDatabase.instance.readAllLocations();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // LocationDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APP 911'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create');
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/map');
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : llamadas.isEmpty
                  ? const Text(
                      'No hay llamadas registradas',
                      style: TextStyle(color: Colors.blue, fontSize: 24),
                    )
                  : buildList()),
    );
  }

  Widget buildList() => ListView.builder(
      itemCount: llamadas.length,
      itemBuilder: (_, int index) {
        final llamada = llamadas[index];
        return ListTile(
          title: Text(llamada.title),
          onLongPress: () {
            Navigator.pushNamed(context, '/detalle',
                arguments: {'id': llamada.id});
          },
        );
      });
}
