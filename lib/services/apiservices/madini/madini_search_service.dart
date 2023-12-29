import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ommyfitness/models/madini/madini_models.dart';
import 'package:ommyfitness/utils/constants.dart';

Future<MadiniModel> getSearchMadini(String searchQuery) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        '$serverUrl/api/fetch_search_madini/',
      ));
  request.fields.addAll({'search_query': searchQuery});

  http.StreamedResponse response = await request.send();

  final statusCode = response.statusCode;
  var responseString = await response.stream.bytesToString();
  dynamic result = json.decode(responseString);
  final madini = MadiniModel.fromJson(result);
  if (statusCode == 401) {
    return MadiniModel();
  } else if (statusCode == 200) {
    MadiniModel modeledData = madini;

    return modeledData;
  } else {
    return MadiniModel();
  }
}
