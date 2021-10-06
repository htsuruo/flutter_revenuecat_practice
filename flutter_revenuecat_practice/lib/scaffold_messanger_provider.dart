import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldMessengerProvider = Provider(
  (ref) => GlobalKey<ScaffoldMessengerState>(),
);

extension ScaffoldMessengerStateEx on ScaffoldMessengerState {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showAfterRemoveSnackBar({
    required String message,
  }) {
    removeCurrentSnackBar();
    return showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
