import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallandim/repositories/earthquake_repository.dart';

class CriticalEarthquakes extends ConsumerStatefulWidget {
  const CriticalEarthquakes({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CriticalEarthquakesState();
}

class _CriticalEarthquakesState extends ConsumerState<CriticalEarthquakes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(eRepository);
    var read = ref.read(eRepository);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Critical Earthquakes"),
        backgroundColor: Colors.amber.shade800,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Color? c = Colors.amber[50];
                  if (double.parse(watch.criticalList[index].buyukluk) > 3.5) {
                    c = Colors.red[900];
                  } else if (double.parse(watch.criticalList[index].buyukluk) >
                      3) {
                    c = Colors.red[400];
                  } else if (double.parse(watch.criticalList[index].buyukluk) >
                      2.5) {
                    c = Colors.red[200];
                  } else if (double.parse(watch.criticalList[index].buyukluk) >
                      2) {
                    c = Colors.amber[200];
                  }
                  return Card(
                    color: c,
                    child: ListTile(
                      leading: Text(
                        watch.criticalList[index].buyukluk,
                        style: const TextStyle(fontSize: 18),
                      ),
                      title: Text(watch.criticalList[index].yer),
                      subtitle: Text(watch.criticalList[index].saat),
                      trailing: IconButton(
                          onPressed: () {
                            read.deleteFromCritical(watch.criticalList[index]);
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                },
                itemCount: watch.criticalList.length),
          ),
        ],
      )),
    );
  }
}
