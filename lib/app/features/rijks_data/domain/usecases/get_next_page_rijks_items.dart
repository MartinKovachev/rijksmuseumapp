import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/core/usecases/i_usecase.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/repositories/i_rijks_data_repository.dart';

@injectable
class GetNextPageRijksItems implements IUseCase<List<RijksItem>, NoParams> {
  final IRijksDataRepository repository;

  GetNextPageRijksItems({required this.repository});

  @override
  Future<Either<IFailure, List<RijksItem>>> call(NoParams params) async {
    return await repository.getRijksItems();
  }
}
