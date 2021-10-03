import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_revenuecat_practice/model/authenticator.dart';
import 'package:flutter_revenuecat_practice/model/purchase_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:subscription_holder/subscription_holder.dart';

final purchaseStateProvider =
    StateNotifierProvider<PurchaseController, PurchaseState>(
  (ref) => PurchaseController(ref.read),
);

class PurchaseController extends StateNotifier<PurchaseState>
    with SubscriptionHolderMixin {
  PurchaseController(this._read) : super(const PurchaseState()) {
    Future(() async {
      final products = await Purchases.getProducts(
        _productIdentifiers,
        type: PurchaseType.inapp,
      );
      // final sub = await Purchases.getProducts(
      //   _productIdentifiers,
      // );
      final offerings = await Purchases.getOfferings();
      logger.fine(offerings.current?.monthly?.product.priceString);
      // TODO(tsuruoka): `paymentDiscount`は何のことかまだ良くわからず
      // final paymentDiscount =
      //     await Purchases.getPaymentDiscount(_productIdentifiers);
      state = state.copyWith(
        products: products,
        offerings: offerings,
      );
    });

    // リスナーも提供されている
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) {
      logger.info('purchaserInfo: $purchaserInfo');
      state = state.copyWith(
        purchaserInfo: purchaserInfo,
      );
    });

    subscriptionHolder.add(
      _read(authStateChanges.stream).listen(
        (user) async {
          if (user == null) {
            logger.info('logout');
            return;
          }
          // RevenueCatのAppUserIDをセット
          final loginResult = await Purchases.logIn(user.uid);
          state = state.copyWith(
            purchaserInfo: loginResult.purchaserInfo,
          );
        },
      ),
    );

    Future<void> purchaseProduct(String productId) =>
        Purchases.purchaseProduct(productId);
  }
  final Reader _read;
  static const _productIdentifiers = [
    // 'test_monthly_sliver',
    // 'test_annual_sliver',
    // 'test_monthly_gold',
    // 'test_annual_gold',
    'jp.mytrade.dev.noads',
  ];
}
