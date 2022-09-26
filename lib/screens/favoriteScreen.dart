import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/documentControllers.dart';
import '../widgets/itemsByCateg.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Documentos favoritos")),
      body: Obx(() => documentController.listDocuments
              .where((p0) => p0.favorite == "1")
              .toList()
              .isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/favorite.json",
                      height: 250, width: 250),
                  const Text("No ha añadido documentos a favoritos.")
                ],
              )),
            )
          : getListDocumentsFavorite(documentController)),
    );
  }
}
