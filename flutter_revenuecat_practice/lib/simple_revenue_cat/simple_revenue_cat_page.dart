import 'package:flutter/material.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_revenuecat_practice/simple_revenue_cat/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimpleRevenueCatPage extends ConsumerWidget {
  const SimpleRevenueCatPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RevenueCat Demo'),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () async {
            final userCredential =
                await ref.read(authRepository).signInWithGoogle();
            logger.fine(userCredential?.user?.uid);
          },
          child: const Text('Google Sign in'),
        ),
      ),
    );
  }
}
