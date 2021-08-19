import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';

class RijksItemModel extends RijksItem {
  const RijksItemModel({
    required String objectNumber,
    required String title,
    required String? headerImageUrl,
    required String principalOrFirstMaker,
  }) : super(
          objectNumber: objectNumber,
          title: title,
          headerImageUrl: headerImageUrl,
          principalOrFirstMaker: principalOrFirstMaker,
        );

  factory RijksItemModel.fromJson(Map<String, dynamic> json) {
    return RijksItemModel(
      objectNumber: json['objectNumber'],
      title: json['title'],
      headerImageUrl: json['headerImage']['url'],
      principalOrFirstMaker: json['principalOrFirstMaker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectNumber': objectNumber,
      'title': title,
      'headerImageUrl': headerImageUrl,
      'principalOrFirstMaker': principalOrFirstMaker,
    };
  }
}
