import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/models/document.dart';
import 'package:wallet/screens/addItem.dart';
import 'package:wallet/screens/personalDocumentsScreen.dart';
import 'package:wallet/screens/utils.dart';
import 'package:wallet/screens/viewItem.dart';
import 'package:wallet/screens/vuelosScreen.dart';

import '../controllers/documentControllers.dart';
import 'aboutUsScreen.dart';
import 'bankCardScreen.dart';
import 'eventScreen.dart';
import 'hospitalDocumentScreen.dart';
import 'hotelScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DocumentController get documentController => Get.put(DocumentController());

  @override
  void dispose() {
    super.dispose();
    // Get.delete<CardController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate:
                        DocumentSearch(documentController.listDocuments.value));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            accountName: const Text("MiWallet"),
            accountEmail: const Text("Tu billetera para todos los documentos"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Image.asset("assets/image/playstore.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Todas'),
              onTap: () {
                Get.to(HomeScreen());
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(CupertinoIcons.person),
              title: const Text('Documentos personales'),
              subtitle: const Text(
                  "Registre sus documentos personales (Documento identidad, Pasaporte)"),
              onTap: () {
                Get.to(PersonalDocumentsScreen());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Tarjetas bancarias'),
              subtitle: const Text("Registre sus tarjetas y la de sus amigos "),
              onTap: () {
                Get.to(TarjetasBancariasScreen());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Métodos médicos'),
              subtitle: const Text(
                  "Registre los métodos entregados en las consultas médicas"),
              onTap: () {
                Get.to(HospitalDocumentScreen());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Reserva eventos'),
              subtitle: const Text("Registre sus reservas de eventos"),
              onTap: () {
                Get.to(EventScreen());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.hotel),
              title: const Text('Reservas hoteleras'),
              subtitle: const Text("Registre sus reservas de hoteles"),
              onTap: () {
                Get.to(HotelScreen());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.airplane_ticket),
              title: const Text('Reservas vuelos'),
              subtitle: const Text("Registre sus reservas de vuelos"),
              onTap: () {
                Get.to(VuelosScreen());
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Sobre nosotros'),
              onTap: () {
                Get.to(AboutUs());
              },
            ),
          ),
        ]),
      ),
      body: Obx(() => documentController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Obx(() => documentController.listDocuments.isEmpty
              ? Center(
                  child: Column(
                  children: [
                    Lottie.asset("assets/lottie/ticket.json",
                        height: 250, width: 250),
                    const Text("No ha registrado documentos. COMIENCE AHORA!")
                  ],
                ))
              : getListDocuments())),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(AddDocument(), arguments: {"category": ""});
          },
          label: const Text("Agregar")),
    );
  }

  getListDocuments() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => ListView.builder(
            itemCount: documentController.listDocuments.length,
            itemBuilder: (context, index) {
              Document documento = documentController.listDocuments[index];
              print(index);
              return GestureDetector(
                onTap: () {
                  Get.to(ViewDocument(), arguments: {"item": documento});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    child: ListTile(
                      title: Text(documento.nombre.toString()),
                      subtitle: Text(
                        documento.categorie.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            print(index);
                            documentController.removeDocument(index);
                          },
                          icon: const Icon(Icons.delete)),
                      leading: getIconDocument(documento.categorie.toString()),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class DocumentSearch extends SearchDelegate {
  final List<Document> listDocuments;

  TextEditingController controller = TextEditingController();

  @override
  String get searchFieldLabel => "Buscar documento";

  DocumentSearch(this.listDocuments);
  String selectResult = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(selectResult),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Document> suggestionList = [];
    for (int i = 0; i < listDocuments.length; i++) {
      if (listDocuments[i].nombre.toString().toLowerCase().contains(query)) {
        suggestionList.add(listDocuments[i]);
      }
    }

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        Document documento = suggestionList[index];
        return InkWell(
          onTap: () {
            Get.to(ViewDocument(), arguments: {"item": documento});
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: const Icon(
                  CupertinoIcons.doc_text,
                  size: 40,
                ),
                title: Text(
                  documento.nombre.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
