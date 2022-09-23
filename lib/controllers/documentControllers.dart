import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wallet/models/document.dart';

import '../screens/editItem.dart';

class DocumentController extends GetxController {
  RxList<String> listCategories = <String>[
    "Documento de identidad",
    "Documento Bancario",
    "Documento médico",
    "Reserva evento",
    "Reserva hotel",
    "Reserva avión",
    "Otros"
  ].obs;

  RxString category = "".obs;
  RxList<Document> listDocuments = <Document>[].obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final txtNombre = TextEditingController();
  final txtImageFront = TextEditingController();
  final txtImageBack = TextEditingController();
  final txtDate = TextEditingController();
  final txtCategory = TextEditingController();

  RxString imageCardMain = "".obs;
  RxString imageCardSecondary = "".obs;
  RxBool changingFavorite = false.obs;

  RxBool isLoading = false.obs;
  RxInt itemByType = 0.obs;

  @override
  void onClose() {
    super.onClose();
    clearController();
  }

  @override
  Future<void> onInit() async {
    getItems();
    super.onInit();
  }

  removeDocument(int index) async {
    var box = await Hive.openBox<Document>("documents");
    box.deleteAt(index);
    update();
    getItems();
  }

  addDocument() async {
    if (formKey.currentState!.validate()) {
      Document item = Document(
          nombre: txtNombre.text,
          categorie: category.value.toString(),
          date: DateTime.now().toString(),
          imageFront: imageCardMain.value.toString(),
          imageBack: imageCardSecondary.value.toString());
      var box = await Hive.openBox<Document>("documents");
      await box.put(DateTime.now().toString(), item);
      update();
      clearController();
      getItems();
      Get.back();
    }
  }

  void setFavoritoValue(int index, String value) async {
    changingFavorite.value = true;
    final box = await Hive.openBox<Document>("documents");
    Document document = box.values.toList().elementAt(index);
    document.favorite = value.toString();
    document.save();
    listDocuments.refresh();
    changingFavorite.value = false;
    update();
  }

  updateDocument(int index) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      final box = await Hive.openBox<Document>("documents");
      Document document = box.values.toList().elementAt(index);
      document.nombre = txtNombre.text;
      document.categorie = txtCategory.text;
      document.imageFront = txtImageFront.text.toString();
      document.imageBack = txtImageBack.text.toString();
      document.save();
      clearController();
      getItems();
      Get.back();
      isLoading.value = false;
      update();
    }
  }

  getItems() async {
    isLoading.value = true;
    final box = await Hive.openBox<Document>("documents");
    listDocuments.value = box.values.toList();
    isLoading.value = false;
    update();
  }

  void clearController() {
    category.value = "";
    txtNombre.text = "";
    txtDate.text = "";
    txtImageBack.text = "";
    txtImageFront.text = "";
    txtCategory.text = "";
    imageCardMain.value = "";
    imageCardSecondary.value = "";
  }
}
