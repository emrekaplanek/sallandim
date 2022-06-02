import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sallandim/models/deprem.dart';
import 'package:sallandim/services/request_service.dart';

class EarthquakeRepository extends ChangeNotifier {
  List<Deprem> depremList = [];
  bool? isLoading;
  void getAllEarthquake() {
    RequestService.get("https://turkiyedepremapi.herokuapp.com/api").then(
      (value) {
        if (value != null) {
          depremList = (json.decode(value) as List)
              .map((item) => Deprem.fromMap(item))
              .toList();
          isLoading = true;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      },
    );
  }
}
