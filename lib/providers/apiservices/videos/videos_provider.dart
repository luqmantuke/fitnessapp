import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/videos/videos_model.dart';
import 'package:ommyfitness/providers/apiservices/api_service_provider.dart';

final fetchVideosProvider = FutureProvider<List<VideosModelData>>((ref) async {
  List<VideosModelData> videos = await ref.read(apiServiceProvider).fetchVideos;

  return videos;
});
