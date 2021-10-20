import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/object_wrappers.dart';

part 'purchase_state.freezed.dart';

@freezed
class PurchaseState with _$PurchaseState {
  factory PurchaseState({
    Offerings? offerings,
  }) = _PurchaseState;
  PurchaseState._();

  late final Offering? currentOffering = offerings?.current;
  late final List<Product>? products =
      offerings?.current?.availablePackages.map((p) => p.product).toList();

  late final Product? product = products?.firstWhereOrNull(
    (e) => e.identifier == _identifier,
  );
}

// TODO(tsuruoka): 本来は`bundle ID`を取得する実装をするとベター
const _identifier = 'com.tsuruoka.flutterRevenueCatPractice.monthly';

// キャメルケースで作ったがAndroidはスネークケースしか作成できないことにあとから気づいた..
// const _identifier = 'com.tsuruoka.flutter_revenuecat_practice.monthly';
