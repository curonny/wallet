import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/documentControllers.dart';
import '../models/document.dart';
import '../widgets/itemsByCateg.dart';
import 'addItem.dart';
import 'utils.dart';

class HospitalDocumentScreen extends StatefulWidget {
  HospitalDocumentScreen({Key? key}) : super(key: key);

  @override
  State<HospitalDocumentScreen> createState() => _HospitalDocumentScreenState();
}

class _HospitalDocumentScreenState extends State<HospitalDocumentScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Documentos personales")),
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/hospital.json",
                      height: 250, width: 250),
                  const Text(
                      "No ha registrado documentos médicos. COMIENCE AHORA!")
                ],
              )),
            )
          : getListDocuments(
              "Método hospitalario", documentController, "hospital")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddDocument(),
                arguments: {"category": "Método hospitalario"});
          },
          label: const Text("Agregar")),
    );
  }
}
