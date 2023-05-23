import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      child: const Center(
        child: SpinKitWave(
          color: Colors.greenAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
