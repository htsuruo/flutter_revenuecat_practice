import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_revenuecat_practice/scaffold_messanger_provider.dart';
import 'package:flutter_revenuecat_practice/simple_purchase_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

const _title = 'Flutter RevenueCat Demo';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      scaffoldMessengerKey: ref.watch(scaffoldMessengerProvider),
      title: _title,
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        splashFactory: InkRipple.splashFactory,
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        dividerTheme: const DividerThemeData(space: 0),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
      ],
      home: const ProgressHUD(
        child: SimplePurchasePage(),
      ),
    );
  }
}
