import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.cyan,
          ),
        ),
      ),
    );
  }
}
