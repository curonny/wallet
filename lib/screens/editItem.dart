import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/documentControllers.dart';
import '../models/document.dart';

class EditDocumentScreen extends StatefulWidget {
  EditDocumentScreen({Key? key}) : super(key: key);

  @override
  State<EditDocumentScreen> createState() => _EditDocumentScreenState();
}

class _EditDocumentScreenState extends State<EditDocumentScreen> {
  DocumentController get documentController => Get.put(DocumentController());

  @override
  Widget build(BuildContext context) {
    Document documento = Get.arguments["document"];
    print(documento.categorie.toString());
    int index = Get.arguments["index"];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Editar documento"),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                documentController.clearController();
                Get.back();
              }),
        ),
        body: formCreateDocument(documento, index),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Get.theme.colorScheme.primary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Text(
                "Actualizar".tr,
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                documentController.updateDocument(index);
                Get.to(() => EditDocumentScreen(),
                    arguments: {"document": documento, "index": index});
              },
            ),
          ),
        ));
  }

  formCreateDocument(Document document, int index) {
    documentController.txtNombre.text = document.nombre.toString();
    documentController.txtCategory.text = document.categorie.toString();
    documentController.txtDate.text = document.date.toString();
    documentController.txtImageBack.text = document.imageBack.toString();
    documentController.txtImageFront.text = document.imageFront.toString();
    documentController.imageCardMain.value = document.imageFront.toString();
    documentController.imageCardSecondary.value = document.imageBack.toString();
    documentController.txtNota1.text = document.notaImg1.toString();
    documentController.txtNota2.text = document.notaImg2.toString();
    return SingleChildScrollView(
        child: Form(
      key: documentController.formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                "Nombre",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                controller: documentController.txtNombre,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.trim() == "") {
                    return "El nombre del documento no puede ser vac??o";
                  }
                  if (value.length > 25) {
                    return "El nombre del documento no puede ser mayor de 25 caracteres";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                cursorColor: Get.theme.colorScheme.primary,
                decoration: const InputDecoration(
                  hintText: "Nombre del documento",
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                "Categor??a",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<String>(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(),
                ),
                onChanged: (value) {
                  if (value != null) {
                    documentController.category.value = value;
                    documentController.txtCategory.text = value;
                  }
                },
                selectedItem: documentController.txtCategory.text,
                items: documentController.listCategories,
                popupProps: const PopupProps.dialog(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                clearButtonProps: const ClearButtonProps(isVisible: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Seleccione la imagen principal".tr,
                    style: Get.theme.textTheme.bodyText2,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Get.theme.colorScheme.secondary,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.camera,
                                          color: Get.theme.backgroundColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Tomar foto".tr,
                                            style: Get.theme.textTheme.headline5
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    _getFromCamera("main");
                                  },
                                ),
                                TextButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Get.theme.backgroundColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Seleccionar desde la galer??a".tr,
                                            style: Get.theme.textTheme.headline5
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    _getFromGallery("main");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        barrierColor: Colors.transparent,
                        isDismissible: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                      );
                    },
                    child: Text(
                      "Cambiar imagen".tr,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                        visible: documentController.imageCardMain.value != "",
                        child: Image.memory(base64Decode(
                            documentController.imageCardMain.toString()))),
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: documentController.txtNota1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  cursorColor: Get.theme.colorScheme.primary,
                  decoration: const InputDecoration(
                    hintText: "Nota de la imagen",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Seleccione la imagen secundaria".tr,
                    style: Get.theme.textTheme.bodyText2,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Get.theme.colorScheme.secondary,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.camera,
                                          color: Get.theme.backgroundColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Tomar foto".tr,
                                            style: Get.theme.textTheme.headline5
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    _getFromCamera("back");
                                  },
                                ),
                                TextButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.image,
                                          color: Get.theme.backgroundColor,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Seleccionar desde la galer??a".tr,
                                            style: Get.theme.textTheme.headline5
                                                ?.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    _getFromGallery("back");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        barrierColor: Colors.transparent,
                        isDismissible: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                      );
                    },
                    child: Text(
                      "Cambiar imagen".tr,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                        visible:
                            documentController.imageCardSecondary.value != "",
                        child: Image.memory(base64Decode(
                            documentController.imageCardSecondary.toString()))),
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: documentController.txtNota2,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  cursorColor: Get.theme.colorScheme.primary,
                  decoration: const InputDecoration(
                    hintText: "Nota de la imagen",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _getFromGallery(String type) async {
    final String path = (await getApplicationDocumentsDirectory()).path;
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );

    if (type == "main") {
      if (imageFile != null) {
        File file = File(imageFile.path.toString());
        Uint8List bytes = file.readAsBytesSync();
        String base64Image = base64Encode(bytes);
        documentController.imageCardMain.value = base64Image;
        documentController.txtImageFront.text = base64Image;
        Get.back();
      }
    }

    if (type == "back") {
      if (imageFile != null) {
        File file = File(imageFile.path.toString());
        Uint8List bytes = file.readAsBytesSync();
        String base64Image = base64Encode(bytes);
        documentController.imageCardSecondary.value = base64Image;
        documentController.txtImageBack.text = base64Image;
        Get.back();
      }
    }
  }

  _getFromCamera(String type) async {
    final String path = (await getApplicationDocumentsDirectory()).path;
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (type == "main") {
      if (imageFile != null) {
        File file = File(imageFile.path.toString());
        Uint8List bytes = file.readAsBytesSync();
        String base64Image = base64Encode(bytes);
        documentController.imageCardMain.value = base64Image;
        documentController.txtImageFront.text = base64Image;
        Get.back();
      }
    }

    if (type == "back") {
      if (imageFile != null) {
        File file = File(imageFile.path.toString());
        Uint8List bytes = file.readAsBytesSync();
        String base64Image = base64Encode(bytes);
        documentController.imageCardSecondary.value = base64Image;
        documentController.txtImageBack.text = base64Image;
        Get.back();
      }
    }
  }
}
