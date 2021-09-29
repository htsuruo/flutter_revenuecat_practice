import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _auth = FirebaseAuth.instance;

final authenticator = Provider((ref) {
  // _auth.authStateChanges().listen((event) {
  //
  // });
});
