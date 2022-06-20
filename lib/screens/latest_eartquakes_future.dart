import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallandim/models/deprem.dart';
import 'package:sallandim/repositories/earthquake_repository.dart';

class LatestEartquakesFuture extends StatelessWidget {
  const LatestEartquakesFuture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Latest earthquake with future")),
      body: const EarthquakesWidget(),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _refreshMe(context)),
    );
  }
}

void _refreshMe(BuildContext context) {}

class EarthquakesWidget extends ConsumerWidget {
  const EarthquakesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Earthquake>?> eProviderF = ref.watch(eRepositoryF);

    return eProviderF.when(
        data: (data) {
          return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Color? c = Colors.amber[50];
                if (double.parse(data![index].buyukluk) > 3.5) {
                  c = Colors.red[900];
                } else if (double.parse(data[index].buyukluk) > 3) {
                  c = Colors.red[400];
                } else if (double.parse(data[index].buyukluk) > 2.5) {
                  c = Colors.red[200];
                } else if (double.parse(data[index].buyukluk) > 2) {
                  c = Colors.amber[200];
                }
                return Card(
                  color: c,
                  child: ListTile(
                    leading: Text(
                      data[index].buyukluk,
                      style: const TextStyle(fontSize: 18),
                    ),
                    title: Text(data[index].yer),
                    subtitle: Row(
                      children: [
                        Text("Time:${data[index].saat} "),
                        if (ref.watch(deepnessIsVisible.state).state)
                          Text("Deepness:${data[index].derinlik}"),
                      ],
                    ),
                  ),
                );
              },
              itemCount: (data?.length));
        },
        error: ((_, __) => const Text("Error Happend")),
        loading: () => CircularProgressIndicator());
  }
}
