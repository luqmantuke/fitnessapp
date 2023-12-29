import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/services/authentication/authentication_service.dart';

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService();
});
