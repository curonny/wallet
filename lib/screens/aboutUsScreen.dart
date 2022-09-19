import 'package:flutter/material.dart';
import 'package:linkable/linkable.dart';

import 'utils.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 100,
        title: Text(
          "Acerca de",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/image/playstore.png",
                              height: 150,
                            ),
                          ),
                          Text(
                            "DWallet",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "Su billetera electrónica para documentos importantes",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Versión 1.0.0",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            const Text(
              "Créditos de DWallet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 15,
                child: ListTile(
                  leading: Image.asset(
                    "assets/image/icon_design.png",
                    height: 40,
                  ),
                  title: Text(
                    "Yari Delgado",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: const Text(
                    "Diseño",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 15,
                child: ListTile(
                  leading: Image.asset(
                    "assets/image/ic_qa.png",
                    height: 40,
                  ),
                  title: Text(
                    "Ing. Rosalina Puerto",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: const Text(
                    "Calidad",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 15,
                child: ListTile(
                  leading: Image.asset(
                    "assets/image/icon_develop.png",
                    height: 40,
                  ),
                  title: Text(
                    "Ing. Ronny Montano",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  subtitle: const Text(
                    "Desarrollo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Protección de datos y privacidad",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  "Los datos recogidos no se envían a terceros, solo son almacenados en el dispositivo para su uso",
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Linkable(
                  text: "Contáctenos: soporte.dwallet@gmail.com",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
