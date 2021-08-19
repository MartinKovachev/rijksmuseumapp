import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';

class RijksItemModel extends RijksItem {
  const RijksItemModel({
    required String id,
    required String objectNumber,
    required String title,
    required String? headerImageUrl,
    required String principalOrFirstMaker,
  }) : super(
          id: id,
          objectNumber: objectNumber,
          title: title,
          headerImageUrl: headerImageUrl,
          principalOrFirstMaker: principalOrFirstMaker,
        );

  factory RijksItemModel.fromJson(Map<String, dynamic> json) {
    return RijksItemModel(
      id: json['id'],
      objectNumber: json['objectNumber'],
      title: json['title'],
      headerImageUrl: json['headerImage']['url'],
      principalOrFirstMaker: json['principalOrFirstMaker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'objectNumber': objectNumber,
      'title': title,
      'headerImageUrl': headerImageUrl,
      'principalOrFirstMaker': principalOrFirstMaker,
    };
  }
}
