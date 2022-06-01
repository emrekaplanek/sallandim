import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallandim/models/deprem.dart';
import 'package:sallandim/repositories/earthquake_repository.dart';
import 'package:sallandim/services/request_service.dart';

final eRepository = ChangeNotifierProvider(((ref) => EarthquakeRepository()));

class LatestEarthquakes extends ConsumerWidget {
  const LatestEarthquakes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: ElevatedButton(
              onPressed: () {
                var read = ref.read(eRepository);
                read.getAllEarthquake();
              },
              child: const Text("Refresh"))),
    );
  }
}
