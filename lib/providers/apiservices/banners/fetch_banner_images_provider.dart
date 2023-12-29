import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/banner/banner_images_model.dart';
import 'package:ommyfitness/providers/apiservices/api_service_provider.dart';

final fetchBannerImagesProvider =
    FutureProvider<List<BannerImagesModelData>>((ref) async {
  List<BannerImagesModelData> bannerImages =
      await ref.read(apiServiceProvider).fetchBannerImage;
  return bannerImages;
});
