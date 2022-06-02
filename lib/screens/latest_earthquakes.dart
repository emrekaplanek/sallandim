import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallandim/repositories/earthquake_repository.dart';
import 'package:sallandim/widgets/loading.dart';

final eRepository = ChangeNotifierProvider(((ref) => EarthquakeRepository()));

class LatestEarthquakes extends ConsumerStatefulWidget {
  const LatestEarthquakes({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LatestEarthquakesState();
}

class _LatestEarthquakesState extends ConsumerState<LatestEarthquakes> {
  @override
  void initState() {
    ref.read(eRepository).getAllEarthquake();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var read = ref.read(eRepository);
    var watch = ref.watch(eRepository);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latest Earthquakes"),
        backgroundColor: Colors.amberAccent.shade700,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Count: ${watch.depremList.length.toString()}"),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber.shade800,
                    ),
                    onPressed: () {
                      var read = ref.read(eRepository);
                      read.getAllEarthquake();
                    },
                    child: const Text("Refresh")),
              ),
            ],
          ),
          Expanded(
            child: Loading(
              isLoading: watch.isLoading,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Color? c = Colors.amber[50];
                    if (double.parse(watch.depremList[index].buyukluk) > 3.5) {
                      c = Colors.red[600];
                    } else if (double.parse(watch.depremList[index].buyukluk) >
                        3) {
                      c = Colors.red[400];
                    } else if (double.parse(watch.depremList[index].buyukluk) >
                        2.5) {
                      c = Colors.red[200];
                    } else if (double.parse(watch.depremList[index].buyukluk) >
                        2) {
                      c = Colors.amber[200];
                    }
                    return Card(
                      color: c,
                      child: ListTile(
                        leading: Text(
                          watch.depremList[index].buyukluk,
                          style: const TextStyle(fontSize: 18),
                        ),
                        title: Text(watch.depremList[index].yer),
                        subtitle: Text(watch.depremList[index].saat),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.star)),
                      ),
                    );
                  },
                  itemCount: watch.depremList.length),
            ),
          ),
        ],
      )),
    );
  }
}
