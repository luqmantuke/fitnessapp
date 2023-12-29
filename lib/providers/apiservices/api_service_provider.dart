import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/services/apiservices/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
