import 'package:flutter/material.dart';

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
