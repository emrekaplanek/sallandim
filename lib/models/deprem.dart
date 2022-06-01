import 'dart:convert';

import 'package:flutter/material.dart';

class Deprem {
  String tarih;
  String saat;
  String enlem;
  String boylam;
  String derinlik;
  String buyuluk;
  String yer;
  String sehir;
  Deprem({
    required this.tarih,
    required this.saat,
    required this.enlem,
    required this.boylam,
    required this.derinlik,
    required this.buyuluk,
    required this.yer,
    required this.sehir,
  });

  Map<String, dynamic> toMap() {
    return {
      'tarih': tarih,
      'saat': saat,
      'enlem': enlem,
      'boylam': boylam,
      'derinlik': derinlik,
      'buyuluk': buyuluk,
      'yer': yer,
      'sehir': sehir,
    };
  }

  factory Deprem.fromMap(Map<String, dynamic> map) {
    return Deprem(
      tarih: map['tarih'] ?? '',
      saat: map['saat'] ?? '',
      enlem: map['enlem'] ?? '',
      boylam: map['boylam'] ?? '',
      derinlik: map['derinlik'] ?? '',
      buyuluk: map['buyuluk'] ?? '',
      yer: map['yer'] ?? '',
      sehir: map['sehir'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Deprem.fromJson(String source) => Deprem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Deprem(tarih: $tarih, saat: $saat, enlem: $enlem, boylam: $boylam, derinlik: $derinlik, buyuluk: $buyuluk, yer: $yer, sehir: $sehir)';
  }
}
