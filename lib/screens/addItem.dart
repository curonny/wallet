import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallet/controllers/documentControllers.dart';

class AddDocument extends StatefulWidget {
  AddDocument({Key? key}) : super(key: key);

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Adicionar documento"),
        ),
        body: formCreateDocument(),
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
              child: Text("Adicionar".tr),
              onPressed: () {
                documentController.addDocument();
              },
            ),
          ),
        ));
  }

  formCreateDocument() {
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
                  if (value == "") {
                    return "El nombre del documento no puede ser vacío";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                cursorColor: Get.theme.colorScheme.primary,
                decoration: const InputDecoration(
                  hintText: "Mi documento de identidad",
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                "Categoría",
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
              padding: const EdgeInsets.all(15.0),
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
                                            "Seleccionar desde la galería".tr,
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
                      "Adicionar imagen".tr,
                      style: TextStyle(color: Get.theme.primaryColor),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                        visible: documentController.imageCardMain.value != "",
                        child: Image.file(
                            File(documentController.imageCardMain.value))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => Visibility(
                    visible: documentController.category.value.toString() ==
                        "Documento de identidad",
                    child: Padding(
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
                                                  color:
                                                      Get.theme.backgroundColor,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Tomar foto".tr,
                                                    style: Get.theme.textTheme
                                                        .headline5
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white),
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
                                                  color:
                                                      Get.theme.backgroundColor,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Seleccionar desde la galería"
                                                        .tr,
                                                    style: Get.theme.textTheme
                                                        .headline5
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white),
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
                              "Adicionar imagen".tr,
                              style: TextStyle(color: Get.theme.primaryColor),
                            ),
                          ),
                          Obx(
                            () => Visibility(
                                visible: documentController
                                        .imageCardSecondary.value !=
                                    "",
                                child: Image.file(File(documentController
                                    .imageCardSecondary.value))),
                          )
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
  }

  _getFromGallery(String type) async {
    print(type);
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (type == "main") {
      if (imageFile != null) {
        documentController.imageCardMain.value = imageFile.path.toString();
        documentController.txtImageFront.text = imageFile.path.toString();
        Get.back();
      }
    }

    if (type == "back") {
      if (imageFile != null) {
        documentController.imageCardSecondary.value = imageFile.path.toString();
        documentController.txtImageBack.text = imageFile.path.toString();
        Get.back();
      }
    }
  }

  _getFromCamera(String type) async {
    print(type);
    ImagePicker imagePicker = ImagePicker();
    final imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (type == "main") {
      if (imageFile != null) {
        documentController.imageCardMain.value = imageFile.path.toString();
        documentController.txtImageFront.text = imageFile.path.toString();
        Get.back();
      }
    }

    if (type == "back") {
      if (imageFile != null) {
        documentController.imageCardSecondary.value = imageFile.path.toString();
        documentController.txtImageBack.text = imageFile.path.toString();
        Get.back();
      }
    }
  }
}
