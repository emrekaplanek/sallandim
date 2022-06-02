import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sallandim/models/deprem.dart';
import 'package:sallandim/services/request_service.dart';

class EarthquakeRepository extends ChangeNotifier {
  List<Deprem> depremList = [];

  void getAllEarthquake() {
    RequestService.get("https://turkiyedepremapi.herokuapp.com/api").then(
      (value) {
        // List<dynamic> data = json.decode(value); // BEST way
        // depremList =
        //     data.map((datam) => Deprem.fromMap(datam)).toList();
        depremList = (json.decode(value) as List) //SHORTEST way
            .map((item) => Deprem.fromMap(item))
            .toList();
        // debugPrint("--List-----------");
        // for (var i = 0; i < depremList.length; i++) {
        //   debugPrint(depremList[i].toString());
        // }
        // debugPrint("--End Of List-----------");
        notifyListeners();
      },
    );
  }
}
