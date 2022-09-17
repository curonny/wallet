import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
    String categoryContext = Get.arguments["category"];
    if (categoryContext.isNotEmpty) {
      documentController.txtCategory.text = categoryContext.toString();
      documentController.category.value = categoryContext.toString();
    }
    @override
    void dispose() {
      super.dispose();
      documentController.onClose();
    }

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
              child: Text(
                "Adicionar".tr,
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (documentController.imageCardMain.value == '') {
                  Get.snackbar("Error",
                      "Debe adicionar al menos una imagen al documento",
                      backgroundColor: Colors.red);
                } else {
                  documentController.addDocument();
                }
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
                  if (value!.trim() == "") {
                    return "El nombre del documento no puede ser vacío";
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
                        child: Image.memory(base64Decode(
                            documentController.imageCardMain.toString()))),
                  )
                ],
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
                                            "Seleccionar desde la galería".tr,
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
                      "Adicionar imagen".tr,
                      style: TextStyle(color: Get.theme.primaryColor),
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
