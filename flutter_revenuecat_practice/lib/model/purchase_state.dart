import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/object_wrappers.dart';

part 'purchase_state.freezed.dart';

@freezed
class PurchaseState with _$PurchaseState {
  const factory PurchaseState({
    PurchaserInfo? purchaserInfo,
    List<Product>? products,
    Offerings? offerings,
  }) = _PurchaseState;
  // PurchaseState._();
}
