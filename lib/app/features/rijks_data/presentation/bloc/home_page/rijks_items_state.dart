part of 'rijks_items_bloc.dart';

@immutable
abstract class RijksItemsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends RijksItemsState {}

class Loaded extends RijksItemsState {
  final List<RijksItem> items;

  Loaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class Error extends RijksItemsState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
