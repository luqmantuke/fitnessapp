///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class CreateSubscriptionModel {
/*
{
  "status": "success",
  "message": "Pushed wallet successfully",
  "status_code": 200
} 
*/

  String? status;
  String? message;
  int? statusCode;

  CreateSubscriptionModel({
    this.status,
    this.message,
    this.statusCode,
  });
  CreateSubscriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    statusCode = json['status_code']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    return data;
  }
}
