import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/screens/viewItem.dart';

import '../controllers/documentControllers.dart';
import '../models/document.dart';
import '../screens/utils.dart';

getListDocuments(
    String category, DocumentController documentController, String icon) {
  RxInt index = 0.obs;
  index.value = documentController.listDocuments
      .indexWhere((element) => element.categorie == category.toString());
  print(index);
  return Obx(
    () => index.value == -1
        ? Lottie.asset("assets/lottie/$icon.json")
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => ListView.builder(
                  itemCount: documentController.listDocuments.length,
                  itemBuilder: (context, index) {
                    Document documento =
                        documentController.listDocuments[index];
                    print(documento.categorie);
                    if (documento.categorie == category.toString()) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ViewDocument(),
                              arguments: {"item": documento});
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
