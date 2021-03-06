import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<IFailure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];

}