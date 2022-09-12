import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/documentControllers.dart';
import '../models/document.dart';
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
      appBar: AppBar(title: const Text("Tarjeta Bancarias")),
      body: getListDocuments(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddDocument(), arguments: {"category": "Tarjeta Bancaria"});
          },
          label: const Text("Agregar")),
    );
  }

  getListDocuments() {
    RxInt index = 0.obs;
    index.value = documentController.listDocuments
        .indexWhere((element) => element.categorie == "Tarjeta Bancaria");
    print(index);
    return Obx(
      () => index.value == -1
          ? Center(
              child: Column(
                children: [
                  Lottie.asset("assets/lottie/cards.json"),
                  const Text(
                      "No ha registrado tarjetas bancarias. COMIENCE AHORA!")
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => ListView.builder(
                    itemCount: documentController.listDocuments.length,
                    itemBuilder: (context, index) {
                      Document documento =
                          documentController.listDocuments[index];
                      print(documento.categorie);
                      if (documento.categorie == "Tarjeta Bancaria") {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 1,
                            child: ExpansionTile(
                              title: Text(documento.nombre.toString()),
                              subtitle: Text(
                                documento.categorie.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: getIconDocument(
                                  documento.categorie.toString()),
                              children: [],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
              ),
            ),
    );
  }
}
