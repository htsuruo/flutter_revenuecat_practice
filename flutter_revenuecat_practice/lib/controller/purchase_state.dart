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
}
