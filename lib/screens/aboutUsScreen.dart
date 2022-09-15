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
                          "Su billetera electrónica para documentos y papeles importantes",
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
            Text(
              "Créditos de DWallet",
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
                            "assets/image/icon_design.png",
                            height: 50,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "Yari Delgado",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: const Text(
                                "Diseñadora",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Image.asset(
                                        "assets/image/ic_whatsapp.png",
                                        height: 20,
                                      ),
                                      onTap: () {
                                        openWhatsapp("+5358129890");
                                      },
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                        "assets/image/ic_telegram.png",
                                        height: 20,
                                      ),
                                      onTap: () {
                                        openTelegram("curonny");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                              title: Text(
                                "Ing. Ronny Montano",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: const Text(
                                "Desarrollador",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Image.asset(
                                        "assets/image/ic_whatsapp.png",
                                        height: 20,
                                      ),
                                      onTap: () {
                                        openWhatsapp("+5358129890");
                                      },
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                        "assets/image/ic_telegram.png",
                                        height: 20,
                                      ),
                                      onTap: () {
                                        openTelegram("curonny");
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
