import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:wallet/models/document.dart';
import 'package:wallet/screens/editItem.dart';

import '../controllers/documentControllers.dart';

class ViewDocument extends StatefulWidget {
  ViewDocument({Key? key}) : super(key: key);

  @override
  State<ViewDocument> createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    Document document = Get.arguments["item"];
    int index = Get.arguments["index"];

    StreamController<Widget> overlayController =
        StreamController<Widget>.broadcast();
    return Obx(() => documentController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text("Documento"),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: () {
                        Get.to(() => EditDocumentScreen(),
                            arguments: {"document": document, "index": index});
                      },
                      icon: const Icon(Icons.edit),
                    )),
                // Icons.favorite_border
                IconButton(
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: () {
                        if (document.favorite == "0") {
                          documentController.setFavoritoValue(index, "1");
                        } else {
                          documentController.setFavoritoValue(index, "0");
                        }
                      },
                      icon: Obx(() => documentController.changingFavorite.value
                          ? const Center(child: CircularProgressIndicator())
                          : document.favorite == '1'
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border)),
                    )),
                IconButton(
                    onPressed: () {},
                    icon: IconButton(
                      onPressed: () {
                        if (document.archived == "0") {
                          documentController.setArchiveValue(index, "1");
                        } else {
                          documentController.setArchiveValue(index, "0");
                        }
                      },
                      icon: Obx(() => documentController.changingFavorite.value
                          ? const Center(child: CircularProgressIndicator())
                          : document.archived == '1'
                              ? const Icon(Icons.archive)
                              : const Icon(Icons.archive_outlined)),
                    )),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(document.categorie.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          document.nombre.toString().toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Registro creado el: ".tr,
                        style: Get.theme.textTheme.bodyText2,
                      ),
                      Text(DateFormat.yMMMd()
                          .format(DateTime.parse(document.date.toString()))),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                              visible:
                                  document.imageFront.toString().isNotEmpty,
                              child: Image.memory(base64Decode(
                                  document.imageFront.toString()))),
                        ),
                        onTap: () {
                          SwipeImageGallery(
                            overlayController: overlayController,
                            initialIndex: 0,
                            backgroundColor: Colors.white,
                            context: context,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.memory(base64Decode(
                                      document.imageFront.toString())),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: InkWell(
                                      child: const Text(
                                        "Cerrar",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onTap: () {
                                        Get.back();
                                      },
                                    )),
                                  )
                                ],
                              );
                            },
                            itemCount: 1,
                          ).show();
                        },
                      ),
                      Center(
                        child: Visibility(
                            visible: document.notaImg1!.isNotEmpty,
                            child: Text(document.notaImg1.toString())),
                      ),
                      InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Visibility(
                                visible:
                                    document.imageBack.toString().isNotEmpty,
                                child: Image.memory(base64Decode(
                                    document.imageBack.toString()))),
                          ),
                          onTap: () {
                            SwipeImageGallery(
                              overlayController: overlayController,
                              initialIndex: 0,
                              backgroundColor: Colors.white,
                              context: context,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.memory(base64Decode(
                                        document.imageBack.toString())),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: InkWell(
                                        child: const Text(
                                          "Cerrar",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onTap: () {
                                          Get.back();
                                        },
                                      )),
                                    )
                                  ],
                                );
                              },
                              itemCount: 1,
                            ).show();
                          }),
                      Center(
                        child: Visibility(
                            visible: document.notaImg2!.isNotEmpty,
                            child: Text(document.notaImg2.toString())),
                      ),
                    ]),
              ),
            ),
          ));
  }
}
