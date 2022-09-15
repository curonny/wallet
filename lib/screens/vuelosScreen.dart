import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/documentControllers.dart';
import '../widgets/itemsByCateg.dart';
import 'addItem.dart';

class VuelosScreen extends StatefulWidget {
  VuelosScreen({Key? key}) : super(key: key);

  @override
  State<VuelosScreen> createState() => _VuelosScreenState();
}

class _VuelosScreenState extends State<VuelosScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservas de  vuelos")),
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/plane.json",
                      height: 250, width: 250),
                  const Text(
                      "No ha registrado reserva de vuelos. COMIENCE AHORA!")
                ],
              )),
            )
          : getListDocuments("Reserva avión", documentController, "plane")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => AddDocument(),
                arguments: {"category": "Reserva avión"});
          },
          label: const Text("Agregar")),
    );
  }
}
