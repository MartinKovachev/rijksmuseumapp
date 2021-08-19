part of 'rijks_items_bloc.dart';

@immutable
abstract class RijksItemsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNextPageRijksItemsEvent extends RijksItemsEvent {}
