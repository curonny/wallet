import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/widgets/itemsByCateg.dart';

import '../controllers/documentControllers.dart';
import '../models/document.dart';
import 'addItem.dart';
import 'utils.dart';

class PersonalDocumentsScreen extends StatefulWidget {
  PersonalDocumentsScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDocumentsScreen> createState() =>
      _PersonalDocumentsScreenState();
}

class _PersonalDocumentsScreenState extends State<PersonalDocumentsScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Documentos de identidad")),
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/scanning.json",
                      height: 250, width: 250),
                  const Text(
                      "No ha registrado documentos de identidad. COMIENCE AHORA!")
                ],
              )),
            )
          : getListDocuments(
              "Documento de identidad", documentController, "scanning")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => AddDocument(),
                arguments: {"category": "Documento de identidad"});
          },
          label: const Text("Agregar")),
    );
  }
}
