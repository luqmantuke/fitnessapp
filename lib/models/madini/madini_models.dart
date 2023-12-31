///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class MadiniModelData {
/*
{
  "id": 1,
  "title": "Testing If it's Working",
  "content": "<p style=\"text-align:center\"><span style=\"color:#dddddd\"><strong>JINISI YA KUKUZA UUME</strong></span></p>\r\n\r\n<p style=\"text-align:center\">&nbsp;</p>\r\n\r\n<p><span style=\"color:#dddddd\"><strong>Karibu kwenye post yetu siku ya leo, tutaenda kuongelea jinsi sahihi ya kuukuza UUME wako naturally kwa kufanya mazoezi na kutumia lishe.</strong></span></p>\r\n\r\n<p><img alt=\"\" src=\"https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ALsA42rrulmnvTiPABV_tA.png\" /></p>\r\n\r\n<p>&nbsp;</p>",
  "images": "https://ommyfitnessbuckett.s3.amazonaws.com/images/madini/images_1.jpeg"
} 
*/

  int? id;
  String? title;
  String? content;
  String? images;

  MadiniModelData({
    this.id,
    this.title,
    this.content,
    this.images,
  });
  MadiniModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    title = json['title']?.toString();
    content = json['content']?.toString();
    images = json['images']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['images'] = images;
    return data;
  }
}

class MadiniModel {
/*
{
  "status": "success",
  "message": "Madini fetched successfully",
  "status_code": 200,
  "data": [
    {
      "id": 1,
      "title": "Testing If it's Working",
      "content": "<p style=\"text-align:center\"><span style=\"color:#dddddd\"><strong>JINISI YA KUKUZA UUME</strong></span></p>\r\n\r\n<p style=\"text-align:center\">&nbsp;</p>\r\n\r\n<p><span style=\"color:#dddddd\"><strong>Karibu kwenye post yetu siku ya leo, tutaenda kuongelea jinsi sahihi ya kuukuza UUME wako naturally kwa kufanya mazoezi na kutumia lishe.</strong></span></p>\r\n\r\n<p><img alt=\"\" src=\"https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ALsA42rrulmnvTiPABV_tA.png\" /></p>\r\n\r\n<p>&nbsp;</p>",
      "images": "https://ommyfitnessbuckett.s3.amazonaws.com/images/madini/images_1.jpeg"
    }
  ]
} 
*/

  String? status;
  String? message;
  int? statusCode;
  List<MadiniModelData?>? data;

  MadiniModel({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });
  MadiniModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    statusCode = json['status_code']?.toInt();
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <MadiniModelData>[];
      v.forEach((v) {
        arr0.add(MadiniModelData.fromJson(v));
      });
      data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['data'] = arr0;
    }
    return data;
  }
}
