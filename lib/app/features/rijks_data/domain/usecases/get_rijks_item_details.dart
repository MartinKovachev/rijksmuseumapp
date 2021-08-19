import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/core/usecases/i_usecase.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/repositories/i_rijks_data_repository.dart';

@injectable
class GetRijksItemDetails
    implements IUseCase<RijksItemDetails, ItemDetailsParams> {
  final IRijksDataRepository repository;

  GetRijksItemDetails({required this.repository});

  @override
  Future<Either<IFailure, RijksItemDetails>> call(
      ItemDetailsParams params) async {
    return await repository.getRijksItemDetails(params.objectNumber);
  }
}

class ItemDetailsParams extends Equatable {
  final String objectNumber;

  const ItemDetailsParams({required this.objectNumber});

  @override
  List<Object?> get props => [objectNumber];
}
