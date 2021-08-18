import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';

class RijksItemDetailsModel extends RijksItemDetails {
  RijksItemDetailsModel({
    required String objectNumber,
    required String title,
    required String description,
    required String? webImageUrl,
  }) : super(
    objectNumber: objectNumber,
    title: title,
    description: description,
    webImageUrl: webImageUrl,
  );

  factory RijksItemDetailsModel.fromJson(Map<String, dynamic> json) {
    return RijksItemDetailsModel(
        objectNumber: json['objectNumber'],
        title: json['title'],
        description: json['description'],
        webImageUrl: json['webImage']['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'objectNumber': objectNumber,
      'title': title,
      'description': description,
      'webImageUrl': webImageUrl,
    };
  }
}
