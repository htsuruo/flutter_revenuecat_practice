import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_revenuecat_practice/model/model.dart';
import 'package:flutter_revenuecat_practice/scaffold_messanger_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tsuruo_kit/tsuruo_kit.dart';

import 'controller/controller.dart';

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
      body: SafeArea(
        child: Column(
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
    final purchaserCount = ref.watch(
      userProvider.select((s) => s.activeEntitlements.length),
    );
    final uid = ref.watch(userProvider.select((s) => s.user?.uid));
    final appUserId = ref.watch(userProvider.select((s) => s.appUserId));
    final activeEntitlements =
        ref.watch(userProvider.select((s) => s.activeEntitlements));
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
                Text('App UserID: $appUserId'),
                Text('Purchased Count: $purchaserCount'),
                ...activeEntitlements
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${e.identifier}'
                              '（${e.willRenew ? '自動更新' : '更新なし'}）',
                              style: theme.textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            Text(
                              '期間: ${e.periodType.described},'
                              '期限: ${e.expirationDate},'
                              '最終更新日: ${e.latestPurchaseDate},',
                              style: theme.textTheme.caption!.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
    );
  }
}

class _PurchaseArea extends ConsumerWidget {
  const _PurchaseArea({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final products = ref.watch(purchaseProvider.select((s) => s.products));
    return products == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'プラン一覧',
                  style: theme.textTheme.caption!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return ListTile(
                      title: Text(p.title),
                      subtitle: Text(p.identifier),
                      trailing: Text(p.priceString),
                      onTap: () async {
                        // 購入
                        final errorCode = await ref
                            .read(progressController)
                            .executeWithProgress(
                              () => ref
                                  .read(purchaseProvider.notifier)
                                  .purchaseProduct(p.identifier),
                            );
                        if (errorCode != null) {
                          ref
                              .read(scaffoldMessengerProvider)
                              .currentState!
                              .showAfterRemoveSnackBar(
                                  message: errorCode.described);
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, _index) => const Divider(),
                ),
              ),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.sync),
                  label: const Text('Restore'),
                  onPressed: () async {
                    // 購入状態を復元
                    final errorCode =
                        await ref.read(progressController).executeWithProgress(
                              () =>
                                  ref.read(purchaseProvider.notifier).restore(),
                            );
                    if (errorCode != null) {
                      // error
                      ref
                          .read(scaffoldMessengerProvider)
                          .currentState!
                          .showAfterRemoveSnackBar(
                              message: errorCode.described);
                    } else {
                      ref
                          .read(scaffoldMessengerProvider)
                          .currentState!
                          .showAfterRemoveSnackBar(
                            message: 'Restore success',
                          );
                    }
                  },
                ),
              )
            ],
          );
  }
}
