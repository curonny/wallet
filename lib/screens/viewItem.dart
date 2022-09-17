import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:wallet/models/document.dart';

class ViewDocument extends StatefulWidget {
  ViewDocument({Key? key}) : super(key: key);

  @override
  State<ViewDocument> createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
  @override
  Widget build(BuildContext context) {
    Document document = Get.arguments["item"];
    print(document.imageFront.toString());

    StreamController<Widget> overlayController =
        StreamController<Widget>.broadcast();
    return Scaffold(
      appBar: AppBar(title: Text(document.categorie.toString())),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                    visible: document.imageFront.toString().isNotEmpty,
                    child: Image.memory(
                        base64Decode(document.imageFront.toString()))),
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
                        Image.memory(
                            base64Decode(document.imageFront.toString())),
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
            InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                      visible: document.imageBack.toString().isNotEmpty,
                      child: Image.memory(
                          base64Decode(document.imageBack.toString()))),
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
                          Image.memory(
                              base64Decode(document.imageBack.toString())),
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
                })
          ]),
        ),
      ),
    );
  }
}
