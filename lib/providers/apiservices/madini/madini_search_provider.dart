import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/madini/madini_models.dart';
import 'package:ommyfitness/providers/apiservices/api_service_provider.dart';

final searchMadinProvider = FutureProvider.family
    .autoDispose<MadiniModel, String>((ref, searchQuery) async {
  MadiniModel searchResult =
      await ref.read(apiServiceProvider).fetchSearchMadini(searchQuery);
  return searchResult;
});
