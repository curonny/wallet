import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:wallet/models/document.dart';
import 'package:wallet/screens/addItem.dart';

import '../controllers/documentControllers.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallet")),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Ashish Rawat"),
            accountEmail: const Text("ashishrawat2911@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: const Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Todas'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Tarjetas bancarias'),
              subtitle: const Text("Registre sus tarjetas y la de sus amigos "),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(CupertinoIcons.person),
              title: const Text('Documentos personales'),
              subtitle: const Text(
                  "Registre sus documentos personales (Documento identidad, Pasaporte)"),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Métodos hospitalarios'),
              subtitle: const Text(
                  "Registre los métodos entregados en las consultas médicas"),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Reserva eventos'),
              subtitle: const Text("Registre sus reservas de eventos"),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.hotel),
              title: const Text('Reservas hoteleras'),
              subtitle: const Text("Registre sus reservas de hoteles"),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.airplane_ticket),
              title: const Text('Reservas vuelos'),
              subtitle: const Text("Registre sus reservas de vuelos"),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Sobre nosotros'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
        ]),
      ),
      body: getListDocuments(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddDocument());
          },
          label: const Text("Agregar")),
    );
  }

  getListDocuments() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => ListView.builder(
            itemCount: documentController.listDocuments.length,
            itemBuilder: (context, index) {
              Document documento = documentController.listDocuments[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 1,
                  child: ExpansionTile(
                    title: Text(documento.nombre.toString()),
                    subtitle: Text(
                      documento.categorie.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: getIconDocument(documento.categorie.toString()),
                    children: [],
                  ),
                ),
              );
            }),
      ),
    );
  }

  //  "Documento de identidad",
  // "Tarjeta Bancaria",
  // "Reserva hotel",
  // "Reserva avión",
  // "Reserva evento",
  // "Método hospitalario"
  getIconDocument(String string) {
    switch (string) {
      case "Documento de identidad":
        return const Icon(Icons.person);
      case "Tarjeta Bancaria":
        return const Icon(Icons.credit_card);
      case "Reserva hotel":
        return const Icon(Icons.hotel);
      case "Reserva avión":
        return const Icon(Icons.airplane_ticket);
      case "Reserva evento":
        return const Icon(Icons.event);
      case "Método hospitalario":
        return const Icon(Icons.local_hospital);
      default:
    }
  }
}
