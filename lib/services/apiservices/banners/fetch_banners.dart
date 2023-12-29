import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ommyfitness/models/banner/banner_images_model.dart';
import 'package:ommyfitness/utils/constants.dart';

Future<List<BannerImagesModelData>> getBannerImages() async {
  var request =
      http.Request('POST', Uri.parse('$serverUrl/api/fetch_banner_images/'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var responseString = await response.stream.bytesToString();
    dynamic result = json.decode(responseString);
    final categories = BannerImagesModel.fromJson(result);
    List<BannerImagesModelData> modeledData =
        categories.data as List<BannerImagesModelData>;
    return modeledData;
  } else {
    return [];
  }
}
