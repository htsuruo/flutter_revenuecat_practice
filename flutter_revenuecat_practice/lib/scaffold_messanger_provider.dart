import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scaffoldMessengerProvider = Provider(
  (ref) => GlobalKey<ScaffoldMessengerState>(),
);
