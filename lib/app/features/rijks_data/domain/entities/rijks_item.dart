import 'package:equatable/equatable.dart';

class RijksItem extends Equatable {
  final String id;
  final String objectNumber;
  final String title;
  final String? headerImageUrl;
  final String principalOrFirstMaker;

  const RijksItem({
    required this.id,
    required this.objectNumber,
    required this.title,
    required this.headerImageUrl,
    required this.principalOrFirstMaker,
  });

  @override
  List<Object?> get props => [
        id,
        objectNumber,
        title,
        headerImageUrl,
        principalOrFirstMaker,
      ];
}
