import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text(document.nombre.toString())),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                  visible: document.imageFront.toString().isNotEmpty,
                  child: Image.file(File(document.imageFront.toString()))),
            ),
            onTap: () {
              SwipeImageGallery(
                initialIndex: 0,
                backgroundColor: Colors.black,
                context: context,
                itemBuilder: (context, index) {
                  return Image.file(
                    File(document.imageFront.toString()),
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
                    child: Image.file(File(document.imageBack.toString()))),
              ),
              onTap: () {
                SwipeImageGallery(
                  initialIndex: 0,
                  backgroundColor: Colors.black,
                  context: context,
                  itemBuilder: (context, index) {
                    return Image.file(
                      File(document.imageFront.toString()),
                    );
                  },
                  itemCount: 1,
                ).show();
              })
        ]),
      ),
    );
  }
}
