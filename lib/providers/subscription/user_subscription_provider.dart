import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/subscription/create_subscription_model.dart';
import 'package:ommyfitness/models/subscription/user_subscription_model.dart';
import 'package:ommyfitness/providers/subscription/subscription_provider.dart';

import '../shared_preferences/shared_preferences_provider.dart';

final userSubscriptionProvider =
    FutureProvider.autoDispose<UserSubscriptionModel>((ref) async {
  String userID = await ref.read(userIdProvider.future);
  UserSubscriptionModel userSubscription =
      await ref.read(subscriptionServiceProvider).fetchUserSubscription(userID);

  return userSubscription;
});

final userSubscriptionStreamProvider =
    StreamProvider<UserSubscriptionModel>((ref) async* {
  String userID = await ref.read(userIdProvider.future);

  // Emit the initial subscription data
  yield await ref
      .read(subscriptionServiceProvider)
      .fetchUserSubscription(userID);

  // Refresh the subscription data every 2 seconds
  while (true) {
    await Future.delayed(const Duration(seconds: 2));
    yield await ref
        .read(subscriptionServiceProvider)
        .fetchUserSubscription(userID);
  }
});

class CreateSubscription extends Equatable {
  final String amount;
  final String phoneNumber;
  const CreateSubscription({
    required this.amount,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [amount, phoneNumber];
}

final createSubscriptionProvider = FutureProvider.autoDispose
    .family<CreateSubscriptionModel, CreateSubscription>((ref, params) async {
  String userID = await ref.read(userIdProvider.future);
  CreateSubscriptionModel createSubscription = await ref
      .read(subscriptionServiceProvider)
      .createSubsciption(userID, params.phoneNumber, params.amount);
  return createSubscription;
});
