import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_state.freezed.dart';

@freezed
class PurchaseState with _$PurchaseState {
  const factory PurchaseState({
    String? hoge,
  }) = _PurchaseState;
  // PurchaseState._();
}
