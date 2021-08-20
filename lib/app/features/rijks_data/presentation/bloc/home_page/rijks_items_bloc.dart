import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rijksmuseumapp/app/core/const/failure_messages.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/usecases/get_page_rijks_items.dart';

part 'rijks_items_event.dart';

part 'rijks_items_state.dart';

@injectable
class RijksItemsBloc extends Bloc<RijksItemsEvent, RijksItemsState> {
  final GetPageRijksItems getRijksItems;

  RijksItemsBloc({required this.getRijksItems}) : super(Loading());

  @override
  Stream<RijksItemsState> mapEventToState(
    RijksItemsEvent event,
  ) async* {
    if (event is GetPageRijksItemsEvent) {
      final failureOrRijksItems = await getRijksItems(
          PageRijksItemsParams(pageNumber: state.pageNumber));
      yield* _eitherLoadedOrErrorState(failureOrRijksItems);
    }
  }

  Stream<RijksItemsState> _eitherLoadedOrErrorState(
    Either<IFailure, List<RijksItem>> failureOrRijksItems,
  ) async* {
    yield failureOrRijksItems.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (items) {
        return Loaded(
            pageNumber: state.pageNumber + 1,
            items: state is Loaded ? (state as Loaded).items + items : items);
      },
    );
  }

  String _mapFailureToMessage(IFailure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return FailureMessages.NETWORK_FAILURE_MESSAGE;
      case ServerFailure:
        return FailureMessages.SERVER_FAILURE_MESSAGE;
      default:
        return FailureMessages.UNDEFINED_FAILURE_MESSAGE;
    }
  }
}
