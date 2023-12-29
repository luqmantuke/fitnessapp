import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/videos/videos_model.dart';
import 'package:ommyfitness/providers/apiservices/api_service_provider.dart';

final searchVideosProvider = FutureProvider.family
    .autoDispose<VideosModel, String>((ref, searchQuery) async {
  VideosModel searchResult =
      await ref.read(apiServiceProvider).fetchSearchVideos(searchQuery);
  return searchResult;
});
