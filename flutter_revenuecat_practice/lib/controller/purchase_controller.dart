import 'package:flutter/services.dart';
import 'package:flutter_revenuecat_practice/controller/controller.dart';
import 'package:flutter_revenuecat_practice/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:subscription_holder/subscription_holder.dart';

final purchaseProvider =
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
  }

  final Reader _read;
  Future<PurchasesErrorCode?> purchaseProduct(String productId) async {
    try {
      await Purchases.purchaseProduct(productId);
      return null;
    } on PlatformException catch (e) {
      // 購入キャンセル
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      logger.warning(errorCode);
      return errorCode;
    }
  }

  Future<PurchasesErrorCode?> restore() async {
    try {
      await Purchases.restoreTransactions();
      // ... check restored purchaserInfo to see if entitlement is now active

      // TODO(tsuruoka): 購入状態（レシート）が見つからない場合には、Exceptionではなくネイティブ側のログが表示される程度なので分岐ができない
      // 購入状態の成功or失敗の判定ができない（同期ボタンという解釈で「更新しました」のSnackBarを表示するのでも十分かも）
      // [Purchases] - WARN: ⚠️ allowSharingAppStoreAccount is set to false and restoreTransactions has been called.
      // Are you sure you want to do this?
      // [Purchases] - DEBUG: ℹ️ Force refreshing the receipt to get latest transactions from Apple.
      // [Purchases] - DEBUG: ℹ️ Loaded receipt from url file:///private/var/mobile/Containers/Data/Application/95D3F798-98D6-4B2B-9C40-4B8EDDFC6186/StoreKit/sandboxReceipt
      // [Purchases] - INFO: ℹ️ Parsing receipt
      // [Purchases] - WARN: ⚠️ /Users/tsuruoka/github/flutter_revenuecat_practice/flutter_revenuecat_practice/ios/Pods/PurchasesCoreSwift/PurchasesCoreSwift/LocalReceiptParsing/ReceiptParser.swift-receiptHasTransactions(receiptData:): Could not parse receipt, conservatively returning true
    } on PlatformException catch (e) {
      // Error restoring purchases
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      logger.warning(errorCode);
      return errorCode;
    }
  }
}
