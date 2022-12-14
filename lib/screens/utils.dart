import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//  "Documento de identidad",
// "Tarjeta Bancaria",
// "Reserva hotel",
// "Reserva avión",
// "Reserva evento",
// "Método hospitalario"
getIconDocument(String string) {
  print(string);
  switch (string) {
    case "Documento de identidad":
      return const Icon(
        Icons.person,
        size: 30,
      );
    case "Documento Bancario":
      return const Icon(
        Icons.credit_card,
        size: 30,
      );
    case "Reserva hotel":
      return const Icon(
        Icons.hotel,
        size: 30,
      );
    case "Reserva avión":
      return const Icon(
        Icons.airplane_ticket,
        size: 30,
      );
    case "Reserva evento":
      return const Icon(
        Icons.event,
        size: 30,
      );
    case "Documento médico":
      return const Icon(
        Icons.local_hospital,
        size: 30,
      );
    case "Otros":
      return const Icon(
        Icons.ads_click_outlined,
        size: 30,
      );
    default:
  }
}

openWhatsapp(String whatsapp) async {
  var whatsappURLiOS =
      "mailto:curonny1992@gmail.com?subject=DWallet&body=Sugerencias sobre DWallet";
  if (await canLaunch(whatsappURLiOS)) {
    await launch(whatsappURLiOS, forceSafariVC: false);
  }
}

openTelegram(String telegram) async {
  var telegramURLiOS =
      "https://t.me/$telegram?text=${Uri.parse('Sugerencias sobre DWallet')}";
  if (await canLaunch(telegramURLiOS)) {
    await launch(telegramURLiOS, forceSafariVC: false);
  }
}

Future<void> launchUrl(Uri url) async {
  if (!await canLaunch(url.toString())) {
    throw 'Could not launch $url';
  }
}

sendingMails() async {
  const url = 'mailto:curonny1992@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
