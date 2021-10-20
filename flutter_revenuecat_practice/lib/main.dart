import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_revenuecat_practice/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:simple_logger/simple_logger.dart';

import 'logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  logger.setLevel(Level.FINE, includeCallerInfo: kDebugMode);

  const apiKey = String.fromEnvironment('API_KEY');
  if (apiKey.isEmpty) {
    const message = 'You must set api key by `--dart-define=API_KEY=xxx`';
    logger.warning(message);
    return runApp(
      const _InvalidDartDefine(message: message),
    );
  }

  // DateTimeのdefaultLocaleをJapaneseに
  Intl.defaultLocale = 'ja';

  // RevenueCat SDKのログ表示(ドキュメント見るとsetupより先に呼んでいる）
  await Purchases.setDebugLogsEnabled(kDebugMode);
  // API Keyでセットアップ
  await Purchases.setup(apiKey);

  // ref. https://pub.dev/packages/in_app_purchase/changelog#060
  // これをしないと下記Assertに引っかかる
  // enablePendingPurchases() must be called when initializing the application
  // 明示的な`in_app_purchase_android`のimportが必要
  InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class _InvalidDartDefine extends StatelessWidget {
  const _InvalidDartDefine({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
