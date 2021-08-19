import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rijksmuseumapp/app/core/errors/exceptions.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/datasources/rijks_data_source.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/repositories/i_rijks_data_repository.dart';

@Injectable(as: IRijksDataRepository)
class RijksDataRepository implements IRijksDataRepository {
  final IRijksDataSource rijksDataSource;

  RijksDataRepository({required this.rijksDataSource});

  @override
  Future<Either<IFailure, RijksItemDetails>> getRijksItemDetails(
      String objectNumber) async {
    try {
      final result = await rijksDataSource.getRijksItemDetails(objectNumber);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<IFailure, List<RijksItem>>> getRijksItems(int pageNumber) async {
    try {
      final result = await rijksDataSource.getNextPageRijksItems(pageNumber);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
