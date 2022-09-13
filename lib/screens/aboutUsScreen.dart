import 'package:flutter/material.dart';

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
                              height: 120,
                            ),
                          ),
                          Text(
                            "RWallet",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Version 1.0.0",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          "Billetera electrónica que funciona de forma offline. Permite al usuario llevar siempre documentos importantes como documentos de identidad, reservas y papeles médicos",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Text(
              "Créditos de RWallet",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/image/icon_develop.png",
                            height: 50,
                          ),
                          Expanded(
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () {
                                  openTelegram("curonny");
                                },
                                icon: Image.asset(
                                  "assets/image/ic_telegram.png",
                                  height: 200,
                                ),
                              ),
                              title: Text(
                                "Ing. Ronny Montano Martínez",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: const Text(
                                "Desarrollador",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    openWhatsapp("+5358129890");
                                  },
                                  icon: Image.asset(
                                    "assets/image/ic_whatsapp.png",
                                    height: 180,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
