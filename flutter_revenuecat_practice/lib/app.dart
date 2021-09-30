import 'package:flutter/material.dart';
import 'package:flutter_revenuecat_practice/simple_revenue_cat/simple_revenue_cat.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

// final _routes = <String, WidgetBuilder>{
//   SimpleRevenueCatPage.routeName: (context) => const SimpleRevenueCatPage(),
// };

const _title = 'Flutter RevenueCat Demo';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      home: const ProgressHUD(
        child: SimpleRevenueCatPage(),
      ),
    );
  }
}
