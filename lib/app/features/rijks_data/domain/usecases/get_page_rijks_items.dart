import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/core/usecases/i_usecase.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/repositories/i_rijks_data_repository.dart';

@injectable
class GetPageRijksItems implements IUseCase<List<RijksItem>, PageRijksItemsParams> {
  final IRijksDataRepository repository;

  GetPageRijksItems({required this.repository});

  @override
  Future<Either<IFailure, List<RijksItem>>> call(PageRijksItemsParams params) async {
    return await repository.getRijksItems(params.pageNumber);
  }
}

class PageRijksItemsParams extends Equatable {
  final int pageNumber;

  const PageRijksItemsParams({required this.pageNumber});

  @override
  List<Object?> get props => [pageNumber];
}
