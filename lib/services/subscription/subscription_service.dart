import 'dart:convert';

import 'package:ommyfitness/models/subscription/create_subscription_model.dart';
import 'package:ommyfitness/models/subscription/plans_model.dart';
import 'package:ommyfitness/models/subscription/user_subscription_model.dart';
import 'package:http/http.dart' as http;
import 'package:ommyfitness/utils/constants.dart';

class SubscriptionService {
  Future<UserSubscriptionModel> fetchUserSubscription(String userID) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$serverUrl/api/fetch_user_subscription/',
        ));
    request.fields.addAll({'user_id': userID});

    http.StreamedResponse response = await request.send();

    final statusCode = response.statusCode;
    var responseString = await response.stream.bytesToString();
    dynamic result = json.decode(responseString);
    final madini = UserSubscriptionModel.fromJson(result);
    if (statusCode == 401) {
      return UserSubscriptionModel();
    } else if (statusCode == 200) {
      UserSubscriptionModel modeledData = madini;

      return modeledData;
    } else {
      return UserSubscriptionModel();
    }
  }

  Future<List<PlansModelData>> fetchUserPlans() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$serverUrl/api/fetch_plans/',
        ));

    http.StreamedResponse response = await request.send();
    var responseString = await response.stream.bytesToString();
    dynamic result = json.decode(responseString);
    final plans = PlansModel.fromJson(result);

    if (plans.statusCode == 401) {
      return [];
    } else if (plans.statusCode == 200) {
      List<PlansModelData> modeledData = plans.data as List<PlansModelData>;

      return modeledData;
    } else {
      return [];
    }
  }

  Future<CreateSubscriptionModel> createSubsciption(
      String userID, String phoneNumber, String amount) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$serverUrl/api/create_subscription/',
        ));
    request.fields.addAll(
        {'user_id': userID, 'phone_number': phoneNumber, 'amount': amount});
    http.StreamedResponse response = await request.send();

    final statusCode = response.statusCode;
    var responseString = await response.stream.bytesToString();
    dynamic result = json.decode(responseString);
    final createSubscription = CreateSubscriptionModel.fromJson(result);
    if (createSubscription.statusCode == 400) {
      CreateSubscriptionModel modeledData = createSubscription;

      return modeledData;
    } else if (statusCode == 200) {
      CreateSubscriptionModel modeledData = createSubscription;

      return modeledData;
    } else {
      return CreateSubscriptionModel(
          statusCode: 400, status: 'error', message: 'Push failed');
    }
  }
}
