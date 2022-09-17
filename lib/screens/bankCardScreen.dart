import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/documentControllers.dart';
import '../models/document.dart';
import '../widgets/itemsByCateg.dart';
import 'addItem.dart';
import 'utils.dart';

class TarjetasBancariasScreen extends StatefulWidget {
  TarjetasBancariasScreen({Key? key}) : super(key: key);

  @override
  State<TarjetasBancariasScreen> createState() =>
      _TarjetasBancariasScreenState();
}

class _TarjetasBancariasScreenState extends State<TarjetasBancariasScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Documentos bancarios")),
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/cards.json",
                      height: 250, width: 250),
                  const Text(
                      "No ha registrado documentos bancarios. COMIENCE AHORA!")
                ],
              )),
            )
          : getListDocuments(
              "Documento Bancario", documentController, "cards")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => AddDocument(),
                arguments: {"category": "Documento Bancario"});
          },
          label: const Text("Agregar")),
    );
  }
}
