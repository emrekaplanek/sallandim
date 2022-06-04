import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallandim/repositories/earthquake_repository.dart';
import 'package:sallandim/widgets/loading.dart';

class LatestEarthquakes extends ConsumerStatefulWidget {
  const LatestEarthquakes({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LatestEarthquakesState();
}

class _LatestEarthquakesState extends ConsumerState<LatestEarthquakes> {
  @override
  void initState() {
    if (ref.read(eRepository).earthquakeList.isEmpty) {
      ref.read(eRepository).getAllEarthquake();
    }
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Count: ${watch.earthquakeList.length.toString()}"),
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber.shade800,
                  ),
                  onPressed: (() {
                    ref.read(deepnessIsVisible.state).state =
                        !ref.read(deepnessIsVisible.state).state;
                  }),
                  child: ref.read(deepnessIsVisible.state).state
                      ? const Text("Hide deepness")
                      : const Text("Show deepness")),
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
          if (ref.watch(deepnessIsVisible) == true)
            const Text("deepness also shown in the list"),
          Expanded(
            child: Loading(
              isLoading: watch.isLoading,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Color? c = Colors.amber[50];
                    if (double.parse(watch.earthquakeList[index].buyukluk) >
                        3.5) {
                      c = Colors.red[900];
                    } else if (double.parse(
                            watch.earthquakeList[index].buyukluk) >
                        3) {
                      c = Colors.red[400];
                    } else if (double.parse(
                            watch.earthquakeList[index].buyukluk) >
                        2.5) {
                      c = Colors.red[200];
                    } else if (double.parse(
                            watch.earthquakeList[index].buyukluk) >
                        2) {
                      c = Colors.amber[200];
                    }
                    return Card(
                      color: c,
                      child: ListTile(
                        leading: Text(
                          watch.earthquakeList[index].buyukluk,
                          style: const TextStyle(fontSize: 18),
                        ),
                        title: Text(watch.earthquakeList[index].yer),
                        subtitle: Row(
                          children: [
                            Text("Time:${watch.earthquakeList[index].saat} "),
                            if (ref.watch(deepnessIsVisible.state).state)
                              Text(
                                  "Deepness:${watch.earthquakeList[index].derinlik}"),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              read.addCritical(watch.earthquakeList[index]);
                            },
                            icon: const Icon(Icons.warning_amber_outlined)),
                      ),
                    );
                  },
                  itemCount: watch.earthquakeList.length),
            ),
          ),
        ],
      )),
    );
  }
}
