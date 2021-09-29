import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_revenuecat_practice/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';

import 'logger.dart';

void main() {
  logger.setLevel(Level.FINE, includeCallerInfo: kDebugMode);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
