import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_revenuecat_practice/model/model.dart';
import 'package:flutter_revenuecat_practice/model/user_controller.dart';
import 'package:flutter_revenuecat_practice/scaffold_messanger_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

class SimplePurchasePage extends ConsumerWidget {
  const SimplePurchasePage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider.select((s) => s.user));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Demo'),
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
          const _UserInfo(),
          Expanded(
            child: user == null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OutlinedButton(
                          onPressed: () async {
                            final userCredential = await ref
                                .read(progressController)
                                .executeWithProgress(
                                  () => ref
                                      .read(authRepository)
                                      .signInWithGoogle(),
                                );
                            logger.fine(userCredential?.user?.uid);
                          },
                          child: const Text('Google Sign in'),
                        ),
                      ],
                    ),
                  )
                : const _PurchaseArea(),
          ),
        ],
      ),
    );
  }
}

class _UserInfo extends ConsumerWidget {
  const _UserInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final purchaserInfo = ref.watch(
          userProvider.select(
              (s) => s.purchaserInfo?.allPurchasedProductIdentifiers.length),
        ) ??
        0;
    final uid = ref.watch(userProvider.select((s) => s.user?.uid));
    return Container(
      width: double.infinity,
      color: colorScheme.primary.withOpacity(.2),
      padding: const EdgeInsets.all(8),
      child: uid == null
          ? const Text('You have to sign in with Google.')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('uid: $uid'),
                Text('Purchased Count: $purchaserInfo'),
              ],
            ),
    );
  }
}

class _PurchaseArea extends ConsumerWidget {
  const _PurchaseArea({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(purchaseStateProvider.select((s) => s.products));
    return products == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: products
                .map(
                  (p) => ListTile(
                    title: Text(p.title),
                    subtitle: Text(p.identifier),
                    trailing: Text(p.priceString),
                    onTap: () async {
                      // 購入
                      final res = await ref
                          .read(purchaseStateProvider.notifier)
                          .purchaseProduct(p.identifier);
                      if (res != null) {
                        ref.read(scaffoldMessengerProvider).currentState!
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(content: Text(res.message!)),
                          );
                      }
                    },
                  ),
                )
                .toList(),
          );
  }
}
