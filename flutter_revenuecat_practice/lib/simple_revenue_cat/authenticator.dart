import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final _auth = FirebaseAuth.instance;

final _authStateChanges = StreamProvider((ref) => _auth.authStateChanges());

final authenticator = Provider<User?>((ref) {
  final user = ref.watch(_authStateChanges).data?.value;
  logger.fine('uid: ${user?.uid}');
  return user;
});

// uidを元にRevenueCatのloginを行なう（PurchaseInfoを受け取る）
final loginResultProvider = FutureProvider((ref) async {
  final user = ref.watch(_authStateChanges).data?.value;
  if (user == null) {
    return null;
  }
  return Purchases.logIn(user.uid);
});
