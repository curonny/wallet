import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
      appBar: AppBar(title: const Text("Documentos personales")),
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/scanning.json"),
                  const Text("No ha registrado documentos. COMIENCE AHORA!")
                ],
              )),
            )
          : getListDocuments()),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddDocument(),
                arguments: {"category": "Documento de identidad"});
          },
          label: const Text("Agregar")),
    );
  }

  getListDocuments() {
    RxInt index = 0.obs;
    index.value = documentController.listDocuments
        .indexWhere((element) => element.categorie == "Documento de identidad");
    print(index);
    return Obx(
      () => index.value == -1
          ? Lottie.asset("assets/lottie/scanning.json")
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => ListView.builder(
                    itemCount: documentController.listDocuments.length,
                    itemBuilder: (context, index) {
                      Document documento =
                          documentController.listDocuments[index];
                      if (documento.categorie == "Documento de identidad") {
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
                              trailing: IconButton(
                                  onPressed: () {
                                    print("a");
                                    documentController.removeDocument(index);
                                  },
                                  icon: const Icon(Icons.delete)),
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
