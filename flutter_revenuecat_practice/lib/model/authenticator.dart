import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _auth = FirebaseAuth.instance;

final authStateChanges = StreamProvider(
  (ref) => _auth.authStateChanges(),
);

final authenticator = Provider<User?>((ref) {
  final user = ref.watch(authStateChanges).data?.value;
  logger.fine('uid: ${user?.uid}');
  return user;
});
