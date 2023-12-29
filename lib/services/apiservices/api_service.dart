import 'package:ommyfitness/services/apiservices/banners/fetch_banners.dart';
import 'package:ommyfitness/services/apiservices/madini/madini_search_service.dart';
import 'package:ommyfitness/services/apiservices/madini/madini_service.dart';
import 'package:ommyfitness/services/apiservices/videos/videos_search_service.dart';
import 'package:ommyfitness/services/apiservices/videos/videos_service.dart';

class ApiService {
  final fetchBannerImage = getBannerImages();
  final fetchMadini = getMadini();
  final fetchVideos = getVideos();
  fetchSearchVideos(String searchQuery) {
    return getSearchVideos(searchQuery);
  }

  fetchSearchMadini(String searchQuery) {
    return getSearchMadini(searchQuery);
  }
}
