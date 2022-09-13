import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/screens/addItem.dart';
import 'package:wallet/widgets/itemsByCateg.dart';

import '../controllers/documentControllers.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reserva evento")),
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/time.json",
                      height: 250, width: 250),
                  const Text(
                      "No ha registrado reserva de eventos. COMIENCE AHORA!")
                ],
              )),
            )
          : getListDocuments("Reserva evento", documentController, "time")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => AddDocument(),
                arguments: {"category": "Reserva evento"});
          },
          label: const Text("Agregar")),
    );
  }
}
