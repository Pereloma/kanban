import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget{
  const LoadingPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const LoadingPage());
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(
          child: LinearProgressIndicator(),
        )
    );
  }

}