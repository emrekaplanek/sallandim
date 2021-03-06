import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallandim/models/deprem.dart';
import 'package:sallandim/services/request_service.dart';

final deepnessIsVisible = StateProvider<bool>(((ref) => false));
final eRepository = ChangeNotifierProvider(((ref) => EarthquakeRepository()));

final eRepositoryF = FutureProvider<List<Earthquake>?>(((ref) {
  List<Earthquake> earthquakeList = [];
  return RequestService.get("https://turkiyedepremapi.herokuapp.com/api").then(
    (value) {
      if (value != null) {
        earthquakeList = (json.decode(value) as List)
            .map((item) => Earthquake.fromMap(item))
            .toList();
        return earthquakeList;
      } else {
        return null;
      }
    },
  );
}));

final eRepositoryF2 = FutureProvider(((ref) {
  return (EarthquakeRepositoryFuture().getAllEarthquake());
}));

class EarthquakeRepositoryFuture {
  List<Earthquake> earthquakeList = [];

  Future<List<Earthquake>?> getAllEarthquake() async {
    RequestService.get("https://turkiyedepremapi.herokuapp.com/api").then(
      (value) {
        if (value != null) {
          earthquakeList = (json.decode(value) as List)
              .map((item) => Earthquake.fromMap(item))
              .toList();
          return earthquakeList;
        } else {
          return null;
        }
      },
    );
  }
}

class EarthquakeRepository extends ChangeNotifier {
  List<Earthquake> earthquakeList = [];
  List<Earthquake> criticalList = [];

  bool? isLoading;
  void getAllEarthquake() {
    RequestService.get("https://turkiyedepremapi.herokuapp.com/api").then(
      (value) {
        if (value != null) {
          earthquakeList = (json.decode(value) as List)
              .map((item) => Earthquake.fromMap(item))
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

  void addCritical(Earthquake d) {
    criticalList.add(d);
    earthquakeList.remove(d);
    notifyListeners();
  }

  void deleteFromCritical(Earthquake d) {
    criticalList.remove(d);
    earthquakeList.add(d);
    notifyListeners();
  }
}
