import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/services/subscription/subscription_service.dart';

final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService();
});
