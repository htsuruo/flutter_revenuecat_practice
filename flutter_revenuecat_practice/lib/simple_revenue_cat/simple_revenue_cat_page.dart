import 'package:flutter/material.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_revenuecat_practice/simple_revenue_cat/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authenticator.dart';

class SimpleRevenueCatPage extends ConsumerWidget {
  const SimpleRevenueCatPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = ref.watch(authenticator);
    return Scaffold(
      appBar: AppBar(
        title: const Text('RevenueCat Demo'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authRepository).signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: colorScheme.primary.withOpacity(.2),
            padding: const EdgeInsets.all(8),
            child: Text('uid: ${user?.uid}'),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      final userCredential =
                          await ref.read(authRepository).signInWithGoogle();
                      logger.fine(userCredential?.user?.uid);
                    },
                    child: const Text('Google Sign in'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
