import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_revenuecat_practice/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:simple_logger/simple_logger.dart';

import 'logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  logger.setLevel(Level.FINE, includeCallerInfo: kDebugMode);

  // API Keyでセットアップ
  await Purchases.setup('xxx');
  // RevenueCat SDKのログ表示
  await Purchases.setDebugLogsEnabled(kDebugMode);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
