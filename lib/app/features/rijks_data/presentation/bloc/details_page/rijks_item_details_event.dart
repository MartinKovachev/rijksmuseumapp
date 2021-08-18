part of 'rijks_item_details_bloc.dart';

@immutable
abstract class RijksItemDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetRijksItemDetailsEvent extends RijksItemDetailsEvent {
  final String objectNumber;

  GetRijksItemDetailsEvent({required this.objectNumber});

  @override
  List<Object?> get props => [objectNumber];
}
