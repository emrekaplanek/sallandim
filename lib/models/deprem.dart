import 'dart:convert';

class Earthquake {
  String tarih;
  String saat;
  String enlem;
  String boylam;
  String derinlik;
  String buyukluk;
  String yer;
  String sehir;
  Earthquake({
    required this.tarih,
    required this.saat,
    required this.enlem,
    required this.boylam,
    required this.derinlik,
    required this.buyukluk,
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
      'buyukluk': buyukluk,
      'yer': yer,
      'sehir': sehir,
    };
  }

  factory Earthquake.fromMap(Map<String, dynamic> map) {
    return Earthquake(
      tarih: map['tarih'] ?? '',
      saat: map['saat'] ?? '',
      enlem: map['enlem'] ?? '',
      boylam: map['boylam'] ?? '',
      derinlik: map['derinlik'] ?? '',
      buyukluk: map['buyukluk'] ?? '',
      yer: map['yer'] ?? '',
      sehir: map['sehir'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Earthquake.fromJson(String source) =>
      Earthquake.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Deprem(tarih: $tarih, saat: $saat, enlem: $enlem, boylam: $boylam, derinlik: $derinlik, buyukluk: $buyukluk, yer: $yer, sehir: $sehir)';
  }
}
