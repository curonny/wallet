import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/screens/viewItem.dart';

import '../controllers/documentControllers.dart';
import '../models/document.dart';
import '../screens/utils.dart';

getListDocuments(
    String category, DocumentController documentController, String icon) {
  RxInt itemLength = 0.obs;
  itemLength.value = documentController.listDocuments
      .where((element) => element.categorie == category)
      .where((element) => element.archived == "0")
      .toList()
      .length;
  return Obx(
    () => itemLength.value == 0
        ? Lottie.asset("assets/lottie/$icon.json")
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => ListView.builder(
                  itemCount: documentController.listDocuments.length,
                  itemBuilder: (context, index) {
                    Document documento =
                        documentController.listDocuments[index];
                    if (documento.categorie == category.toString() &&
                        documento.archived == "0") {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ViewDocument(),
                              arguments: {"item": documento, "index": index});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 1,
                            child: ListTile(
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
                                    documentController.removeDocument(index);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ),
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

getListDocumentsFavorite(DocumentController documentController) {
  RxInt itemLength = 0.obs;
  itemLength.value = documentController.listDocuments
      .where((element) => element.favorite == "1")
      .toList()
      .length;
  return Obx(
    () => itemLength.value == 0
        ? Lottie.asset("assets/lottie/favorite.json")
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => ListView.builder(
                  itemCount: documentController.listDocuments.length,
                  itemBuilder: (context, index) {
                    Document documento =
                        documentController.listDocuments[index];
                    if (documento.favorite == "1") {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ViewDocument(),
                              arguments: {"item": documento, "index": index});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 1,
                            child: ListTile(
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
                                    documentController.removeDocument(index);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ),
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

getListDocumentsArchived(DocumentController documentController) {
  RxInt index = 0.obs;
  index.value = documentController.listDocuments
      .indexWhere((element) => element.archived == "1");
  return Obx(
    () => index.value == -1
        ? Center(
            child: Column(
              children: [
                Lottie.asset("assets/lottie/archived.json"),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("No hay documentos archivados"),
                ),
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
                    if (documento.archived == "1") {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ViewDocument(),
                              arguments: {"item": documento, "index": index});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 1,
                            child: ListTile(
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
                                    documentController.removeDocument(index);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ),
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
