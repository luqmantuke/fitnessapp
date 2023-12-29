import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/madini/madini_models.dart';
import 'package:ommyfitness/providers/apiservices/api_service_provider.dart';

final fetchMadiniProvider = FutureProvider<List<MadiniModelData>>((ref) async {
  List<MadiniModelData> madini = await ref.read(apiServiceProvider).fetchMadini;

  return madini;
});
