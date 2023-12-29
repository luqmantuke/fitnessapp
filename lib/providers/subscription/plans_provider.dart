import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/subscription/plans_model.dart';
import 'package:ommyfitness/providers/subscription/subscription_provider.dart';

final fetchPlansProvider =
    FutureProvider.autoDispose<List<PlansModelData>>((ref) async {
  List<PlansModelData> plans =
      await ref.read(subscriptionServiceProvider).fetchUserPlans();
  return plans;
});
