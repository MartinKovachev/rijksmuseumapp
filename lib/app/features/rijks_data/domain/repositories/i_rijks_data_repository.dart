import 'package:dartz/dartz.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';

abstract class IRijksDataRepository {
  Future<Either<IFailure, List<RijksItem>>> getRijksItems();
  Future<Either<IFailure, RijksItemDetails>> getRijksItemDetails(String objectNumber);
}