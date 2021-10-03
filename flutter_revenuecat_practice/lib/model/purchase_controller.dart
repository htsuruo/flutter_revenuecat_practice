import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_revenuecat_practice/model/purchase_state.dart';
import 'package:flutter_revenuecat_practice/simple_revenue_cat/authenticator.dart';
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
      final products = await Purchases.getProducts(_productIdentifiers);
      final offerings = await Purchases.getOfferings();
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
  }
  final Reader _read;
  static const _productIdentifiers = [''];
}
