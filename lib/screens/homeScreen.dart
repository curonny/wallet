import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:wallet/models/document.dart';
import 'package:wallet/screens/addItem.dart';
import 'package:wallet/screens/archiveScreen.dart';
import 'package:wallet/screens/personalDocumentsScreen.dart';
import 'package:wallet/screens/utils.dart';
import 'package:wallet/screens/viewItem.dart';
import 'package:wallet/screens/vuelosScreen.dart';

import '../controllers/documentControllers.dart';
import 'aboutUsScreen.dart';
import 'bankCardScreen.dart';
import 'eventScreen.dart';
import 'favoriteScreen.dart';
import 'hospitalDocumentScreen.dart';
import 'hotelScreen.dart';
import 'otherScreen.dart';

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
        title: const Text("DWallet"),
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
        child: SingleChildScrollView(
            child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("DWallet"),
              accountEmail: const Text(
                "La billetera electrónica para tus documentos",
                maxLines: 3,
                style: TextStyle(fontSize: 16),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 200,
                backgroundColor: Colors.blue,
                child: Image.asset("assets/image/playstore.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Todas'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favoritos'),
                onTap: () {
                  Get.to(() => FavoritesScreen());
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(CupertinoIcons.person),
                title: const Text('Documentos de identidad'),
                subtitle:
                    const Text("Registre su documento identidad y pasaporte"),
                onTap: () {
                  Get.to(() => PersonalDocumentsScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Documentos bancarios'),
                subtitle:
                    const Text("Registre sus tarjetas y la de sus amigos "),
                onTap: () {
                  Get.to(() => TarjetasBancariasScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.local_hospital),
                title: const Text('Documentos médicos'),
                subtitle: const Text("Registre documentos médicos"),
                onTap: () {
                  Get.to(() => HospitalDocumentScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Reservas eventos'),
                subtitle: const Text("Registre sus reservas de eventos"),
                onTap: () {
                  Get.to(() => EventScreen());
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
                  Get.to(() => HotelScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.airplane_ticket),
                title: const Text('Reservas avión'),
                subtitle: const Text("Registre sus reservas de vuelos"),
                onTap: () {
                  Get.to(() => VuelosScreen());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.ads_click_outlined),
                title: const Text('Otros'),
                subtitle: const Text("Registre cualquier documento"),
                onTap: () {
                  Get.to(() => OhtersScreen());
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
                  Get.to(() => AboutUs());
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.archive),
                title: const Text('Archivados'),
                onTap: () {
                  Get.to(() => ArchiveScreen());
                },
              ),
            ),
            const Divider(),
          ],
        )),
      ),
      body: Obx(() => documentController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Obx(() => documentController.listDocuments
                  .where((p0) => p0.archived == "0")
                  .toList()
                  .isEmpty
              ? Center(
                  child: Column(
                  children: [
                    Lottie.asset("assets/lottie/ticket.json",
                        height: 250, width: 250),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                          child: Text(
                              "No ha registrado documentos. COMIENCE AHORA!")),
                    )
                  ],
                ))
              : getListDocuments())),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => AddDocument(), arguments: {"category": ""});
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
              if (documento.archived == "0" || documento.archived == null) {
                return documento.favorite == "1"
                    ? GestureDetector(
                        onTap: () {
                          Get.to(() => ViewDocument(),
                              arguments: {"item": documento, "index": index});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Banner(
                            location: BannerLocation.topStart,
                            message: "fav",
                            color: Colors.red,
                            child: Card(
                              elevation: 1,
                              child: ListTile(
                                title: Text(documento.nombre.toString()),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      documento.categorie.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(DateFormat.yMMMd().format(
                                        DateTime.parse(
                                            documento.date.toString())))
                                  ],
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    documentController.removeDocument(index);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    size: 20,
                                  ),
                                ),
                                leading: getIconDocument(
                                    documento.categorie.toString()),
                              ),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Get.to(() => ViewDocument(),
                              arguments: {"item": documento, "index": index});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 1,
                            child: ListTile(
                              title: Text(documento.nombre.toString()),
                              subtitle: Column(
                                children: [
                                  Text(
                                    documento.categorie.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(DateFormat.yMMMd().format(DateTime.parse(
                                      documento.date.toString())))
                                ],
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  documentController.removeDocument(index);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 20,
                                ),
                              ),
                              leading: getIconDocument(
                                  documento.categorie.toString()),
                            ),
                          ),
                        ),
                      );
              } else {
                return const SizedBox();
              }
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
      if (listDocuments[i]
              .nombre
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          listDocuments[i]
              .categorie
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          listDocuments[i]
              .notaImg1
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          listDocuments[i]
              .notaImg2
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase())) {
        suggestionList.add(listDocuments[i]);
      }
    }

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        Document documento = suggestionList[index];
        return InkWell(
          onTap: () {
            Get.to(() => ViewDocument(),
                arguments: {"item": documento, "index": index});
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
