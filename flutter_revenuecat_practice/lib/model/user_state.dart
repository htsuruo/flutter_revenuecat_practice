import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/object_wrappers.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  factory UserState({
    User? user,
    PurchaserInfo? purchaserInfo,
  }) = _UserState;
  UserState._();

  late final bool isPaidUser =
      purchaserInfo?.allPurchasedProductIdentifiers.isNotEmpty ?? false;
}
