import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_revenuecat_practice/controller/controller.dart';
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
    // リスナーも提供されている
    Purchases.addPurchaserInfoUpdateListener(
      (purchaserInfo) {
        logger.info('purchaserInfo: $purchaserInfo');
        state = state.copyWith(
          purchaserInfo: purchaserInfo,
        );
      },
    );

    Purchases.removePurchaserInfoUpdateListener(
      (purchaserInfo) {
        logger.info('purchaserInfo: $purchaserInfo');
        state = state.copyWith(
          purchaserInfo: purchaserInfo,
        );
      },
    );

    subscriptionHolder.add(
      _auth.authStateChanges().listen(
        (user) async {
          if (user == null) {
            logger.info('logout');
            state = UserState();
            return;
          }
          // RevenueCatのAppUserIDをセット
          final loginResult = await Purchases.logIn(user.uid);
          state = state.copyWith(
            user: user,
            purchaserInfo: loginResult.purchaserInfo,
          );
        },
      ),
    );
  }

  final _auth = FirebaseAuth.instance;
}
