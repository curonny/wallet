import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:wallet/models/document.dart';

class DocumentController extends GetxController {
  RxList<String> listCategories = <String>[
    "Documento de identidad",
    "Tarjeta Bancaria",
    "Reserva hotel",
    "Reserva avión",
    "Reserva evento",
    "Método hospitalario"
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

  RxBool isLoading = false.obs;
  RxInt itemByType = 0.obs;

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

  getItems() async {
    isLoading.value = true;
    final box = await Hive.openBox<Document>("documents");
    listDocuments.value = box.values.toList();
    listDocuments.sort((a, b) => b.date!.compareTo(a.date!));
    isLoading.value = false;
    update();
  }

  void clearController() {
    category.value = "";
    txtNombre.text = "";
    txtDate.text = "";
    txtImageBack.text = "";
    txtImageFront.text = "";
    imageCardMain.value = "";
    imageCardSecondary.value = "";
  }
}
