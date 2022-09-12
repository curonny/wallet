import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/models/document.dart';
import 'package:wallet/screens/addItem.dart';
import 'package:wallet/screens/personalDocumentsScreen.dart';
import 'package:wallet/screens/utils.dart';

import '../controllers/documentControllers.dart';
import 'bankCardScreen.dart';
import 'hospitalDocumentScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DocumentController get documentController => Get.put(DocumentController());

  @override
  void dispose() {
    super.dispose();
    // Get.delete<CardController>();
  }

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
                Get.to(HomeScreen());
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(CupertinoIcons.person),
              title: const Text('Documentos personales'),
              subtitle: const Text(
                  "Registre sus documentos personales (Documento identidad, Pasaporte)"),
              onTap: () {
                Get.to(PersonalDocumentsScreen());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Tarjetas bancarias'),
              subtitle: const Text("Registre sus tarjetas y la de sus amigos "),
              onTap: () {
                Get.to(TarjetasBancariasScreen());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Métodos médicos'),
              subtitle: const Text(
                  "Registre los métodos entregados en las consultas médicas"),
              onTap: () {
                Get.to(HospitalDocumentScreen());
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
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Center(
              child: Column(
              children: [
                Lottie.asset("assets/lottie/ticket.json"),
                const Text("No ha registrado documentos. COMIENCE AHORA!")
              ],
            ))
          : getListDocuments()),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddDocument(), arguments: {"category": ""});
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
                    trailing: IconButton(
                        onPressed: () {
                          print("a");
                          documentController.removeDocument(index);
                        },
                        icon: const Icon(Icons.delete)),
                    leading: getIconDocument(documento.categorie.toString()),
                    children: [],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
