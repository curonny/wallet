import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyAppScreen extends StatefulWidget {
  BuyAppScreen({Key? key}) : super(key: key);

  @override
  State<BuyAppScreen> createState() => _BuyAppScreenState();
}

class _BuyAppScreenState extends State<BuyAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffa6d8be),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset('assets/image/playstore.png'),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Su billetera electrónica para documentos y papeles importantes",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Por qué comprar DWallet?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Es una aplicación que emula una billetera física, que permite llevar siempre los documentos en forma digital",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  child: const Text(
                    "CÓMPRELA AHORA ! y comience a ORGANIZAR sus DOCUMENTOS 😎",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        "https://www.apklis.cu/application/com.curonny.dwallet"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
