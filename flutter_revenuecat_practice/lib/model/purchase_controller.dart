import 'package:flutter/services.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_revenuecat_practice/model/purchase_state.dart';
import 'package:flutter_revenuecat_practice/model/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:subscription_holder/subscription_holder.dart';

final purchaseStateProvider =
    StateNotifierProvider<PurchaseController, PurchaseState>(
  (ref) => PurchaseController(ref.read),
);

class PurchaseController extends StateNotifier<PurchaseState>
    with SubscriptionHolderMixin {
  PurchaseController(this._read) : super(PurchaseState()) {
    Future(() async {
      try {
        final offerings = await Purchases.getOfferings();
        logger.fine('Offerings current: ${offerings.current}');
        // currentの設定がない場合など
        if (offerings.current == null ||
            offerings.current!.availablePackages.isEmpty) {
          state = state.copyWith(offerings: null);
          return;
        }
        state = state.copyWith(offerings: offerings);
      } on PlatformException catch (e) {
        logger.warning(e);
        state = state.copyWith(offerings: null);
      }
    });

    // リスナーも提供されている
    Purchases.addPurchaserInfoUpdateListener(
      (purchaserInfo) {
        logger.info('purchaserInfo: $purchaserInfo');
        _read(userProvider.notifier).updatePurchaseInfo(purchaserInfo);
      },
    );
  }

  final Reader _read;
  Future<PlatformException?> purchaseProduct(String productId) async {
    try {
      await Purchases.purchaseProduct(productId);
      return null;
    } on PlatformException catch (e) {
      // 購入キャンセル
      logger.warning(e);
      return e;
    }
  }
}
