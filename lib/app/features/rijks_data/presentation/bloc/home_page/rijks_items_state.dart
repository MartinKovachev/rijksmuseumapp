part of 'rijks_items_bloc.dart';

@immutable
abstract class RijksItemsState extends Equatable {
  final int pageNumber;

  RijksItemsState({required this.pageNumber});

  @override
  List<Object?> get props => [pageNumber];
}

class Loading extends RijksItemsState {
  Loading() : super(pageNumber: 1);
}

class Loaded extends RijksItemsState {
  final List<RijksItem> items;

  Loaded({required pageNumber, required this.items}) : super(pageNumber: pageNumber);

  @override
  List<Object?> get props => [items];
}

class Error extends RijksItemsState {
  final String message;

  Error({required this.message}) : super(pageNumber: 1);

  @override
  List<Object?> get props => [message];
}
