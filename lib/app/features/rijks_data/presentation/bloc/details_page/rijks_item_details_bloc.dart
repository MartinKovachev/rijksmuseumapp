import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rijksmuseumapp/app/core/const/failure_messages.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/usecases/get_rijks_item_details.dart';

part 'rijks_item_details_event.dart';

part 'rijks_item_details_state.dart';

@injectable
class RijksItemDetailsBloc
    extends Bloc<RijksItemDetailsEvent, RijksItemDetailsState> {
  final GetRijksItemDetails getRijksItemDetails;

  RijksItemDetailsBloc({required this.getRijksItemDetails}) : super(Loading());

  @override
  Stream<RijksItemDetailsState> mapEventToState(
    RijksItemDetailsEvent event,
  ) async* {
    if (event is GetRijksItemDetailsEvent) {
      yield Loading();
      final failureOrRijksItems = await getRijksItemDetails(
        ItemDetailsParams(
          objectNumber: event.objectNumber,
        ),
      );
      yield* _eitherLoadedOrErrorState(failureOrRijksItems);
    }
  }

  Stream<RijksItemDetailsState> _eitherLoadedOrErrorState(
    Either<IFailure, RijksItemDetails> failureOrRijksItemDetails,
  ) async* {
    yield failureOrRijksItemDetails.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (item) => Loaded(item: item),
    );
  }

  String _mapFailureToMessage(IFailure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FailureMessages.SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
