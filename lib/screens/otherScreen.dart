import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/documentControllers.dart';
import '../widgets/itemsByCateg.dart';
import 'addItem.dart';

class OhtersScreen extends StatefulWidget {
  OhtersScreen({Key? key}) : super(key: key);

  @override
  State<OhtersScreen> createState() => _OhtersScreenState();
}

class _OhtersScreenState extends State<OhtersScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Otros")),
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/other.json",
                      height: 250, width: 250),
                  const Text(
                      "No ha registrado documentos misceláneos. COMIENCE AHORA!")
                ],
              )),
            )
          : getListDocuments("Otros", documentController, "other")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => AddDocument(), arguments: {"category": "Otros"});
          },
          label: const Text("Agregar")),
    );
  }
}
