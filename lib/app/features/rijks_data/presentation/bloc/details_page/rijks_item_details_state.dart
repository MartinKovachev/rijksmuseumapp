part of 'rijks_item_details_bloc.dart';

@immutable
abstract class RijksItemDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends RijksItemDetailsState {}

class Loaded extends RijksItemDetailsState {
  final RijksItemDetails item;

  Loaded({required this.item});

  @override
  List<Object?> get props => [item];
}

class Error extends RijksItemDetailsState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
