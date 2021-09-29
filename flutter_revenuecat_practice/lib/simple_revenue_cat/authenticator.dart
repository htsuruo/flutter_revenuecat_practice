import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _auth = FirebaseAuth.instance;

final _authStateChanges = StreamProvider((ref) => _auth.authStateChanges());

final authenticator = Provider<User?>((ref) {
  final user = ref.watch(_authStateChanges).data?.value;
  logger.fine('user: ${user?.uid}');
  return user;
});
