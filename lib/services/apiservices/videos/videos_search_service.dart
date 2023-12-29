import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ommyfitness/models/videos/videos_model.dart';
import 'package:ommyfitness/utils/constants.dart';

Future<VideosModel> getSearchVideos(String searchQuery) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        '$serverUrl/api/fetch_search_videos/',
      ));
  request.fields.addAll({'search_query': searchQuery});

  http.StreamedResponse response = await request.send();

  final statusCode = response.statusCode;
  var responseString = await response.stream.bytesToString();
  dynamic result = json.decode(responseString);
  final videos = VideosModel.fromJson(result);
  if (statusCode == 401) {
    return VideosModel();
  } else if (statusCode == 200) {
    VideosModel modeledData = videos;

    return modeledData;
  } else {
    return VideosModel();
  }
}
