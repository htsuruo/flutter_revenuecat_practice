import 'package:flutter/material.dart';

class SimpleRevenueCatPage extends StatelessWidget {
  const SimpleRevenueCatPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RevenueCat Demo'),
      ),
    );
  }
}
