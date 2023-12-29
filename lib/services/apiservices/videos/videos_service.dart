import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ommyfitness/models/videos/videos_model.dart';
import 'package:ommyfitness/utils/constants.dart';

Future<List<VideosModelData>> getVideos() async {
  var request = http.Request('POST', Uri.parse('$serverUrl/api/fetch_videos/'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var responseString = await response.stream.bytesToString();
    dynamic result = json.decode(responseString);
    final videos = VideosModel.fromJson(result);
    List<VideosModelData> modeledData = videos.data as List<VideosModelData>;
    return modeledData;
  } else {
    return [];
  }
}
