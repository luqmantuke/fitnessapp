import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ommyfitness/models/madini/madini_models.dart';
import 'package:ommyfitness/utils/constants.dart';

Future<List<MadiniModelData>> getMadini() async {
  var request = http.Request('POST', Uri.parse('$serverUrl/api/fetch_madini/'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var responseString = await response.stream.bytesToString();
    dynamic result = json.decode(responseString);
    final madini = MadiniModel.fromJson(result);
    List<MadiniModelData> modeledData = madini.data as List<MadiniModelData>;
    return modeledData;
  } else {
    return [];
  }
}
