import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//  "Documento de identidad",
// "Tarjeta Bancaria",
// "Reserva hotel",
// "Reserva avión",
// "Reserva evento",
// "Método hospitalario"
getIconDocument(String string) {
  switch (string) {
    case "Documento de identidad":
      return const Icon(Icons.person);
    case "Tarjeta Bancaria":
      return const Icon(Icons.credit_card);
    case "Reserva hotel":
      return const Icon(Icons.hotel);
    case "Reserva avión":
      return const Icon(Icons.airplane_ticket);
    case "Reserva evento":
      return const Icon(Icons.event);
    case "Método hospitalario":
      return const Icon(Icons.local_hospital);
    default:
  }
}

openWhatsapp(String whatsapp) async {
  var whatsappURLiOS =
      "https://wa.me/$whatsapp?text=${Uri.parse('Sugerencias sobre MiWallet')}";
  if (await canLaunch(whatsappURLiOS)) {
    await launch(whatsappURLiOS, forceSafariVC: false);
  }
}

openTelegram(String telegram) async {
  var telegramURLiOS =
      "https://t.me/$telegram?text=${Uri.parse('Sugerencias sobre MiWallet')}";
  if (await canLaunch(telegramURLiOS)) {
    await launch(telegramURLiOS, forceSafariVC: false);
  }
}
