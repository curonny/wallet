import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/documentControllers.dart';
import '../widgets/itemsByCateg.dart';
import 'addItem.dart';

class HotelScreen extends StatefulWidget {
  HotelScreen({Key? key}) : super(key: key);

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  DocumentController get documentController => Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reserva hoteles")),
      body: Obx(() => documentController.listDocuments.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: Column(
                children: [
                  Lottie.asset("assets/lottie/hotel.json",
                      height: 250, width: 250),
                  const Text(
                      "No ha registrado reserva de hoteles. COMIENCE AHORA!")
                ],
              )),
            )
          : getListDocuments("Reserva hotel", documentController, "hotel")),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddDocument(), arguments: {"category": "Reserva hotel"});
          },
          label: const Text("Agregar")),
    );
  }
}
