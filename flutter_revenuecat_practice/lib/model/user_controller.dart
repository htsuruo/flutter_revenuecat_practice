import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_revenuecat_practice/model/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:subscription_holder/subscription_holder.dart';

import '../logger.dart';

final userProvider = StateNotifierProvider<UserController, UserState>(
  (ref) => UserController(),
);

class UserController extends StateNotifier<UserState>
    with SubscriptionHolderMixin {
  UserController() : super(UserState()) {
    subscriptionHolder.add(
      _auth.authStateChanges().listen(
        (user) async {
          if (user == null) {
            logger.info('logout');
            state = UserState();
            return;
          }
          state = state.copyWith(user: user);
          // RevenueCatのAppUserIDをセット
          final loginResult = await Purchases.logIn(user.uid);
          updatePurchaseInfo(loginResult.purchaserInfo);
        },
      ),
    );
  }

  final _auth = FirebaseAuth.instance;

  void updatePurchaseInfo(PurchaserInfo purchaserInfo) {
    state = state.copyWith(
      purchaserInfo: purchaserInfo,
    );
  }
}
