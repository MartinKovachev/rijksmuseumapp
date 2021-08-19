import 'package:equatable/equatable.dart';

class RijksItemDetails extends Equatable {
  final String objectNumber;
  final String title;
  final String? description;
  final String? webImageUrl;

  const RijksItemDetails({
    required this.objectNumber,
    required this.title,
    required this.description,
    required this.webImageUrl,
  });

  @override
  List<Object?> get props => [
        objectNumber,
        title,
        description,
        webImageUrl,
      ];
}
