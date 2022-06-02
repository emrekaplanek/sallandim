import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  bool? isLoading;
  Widget child;
  Loading({
    Key? key,
    this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading == null) {
      return Column(
        children: const [CircularProgressIndicator(), Text("Loading...")],
      );
    } else if (isLoading == false) {
      return const Text("hata oluştu");
    } else {
      return child;
    }
  }
}
