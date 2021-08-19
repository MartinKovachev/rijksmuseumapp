import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/usecases/get_page_with_rijks_items.dart';

import '../../../../../mocks.dart';

void main() {
  late GetPageWithRijksItems usecase;
  late MockIRijksDataRepository mockIRijksDataRepository;

  setUp(() {
    mockIRijksDataRepository = MockIRijksDataRepository();
    usecase = GetPageWithRijksItems(repository: mockIRijksDataRepository);
  });

  final pageNumber = 1;
  final listRijksItems = List<RijksItem>.generate(
    5,
    (i) => RijksItem(
      id: '1111',
      objectNumber: '1111',
      title: 'test',
      headerImageUrl: 'test',
      principalOrFirstMaker: 'test',
    ),
  );

  test(
      'should get list with rijks items for the passed pageNumber from the repository',
      () async {
    // arrange
    when(() => mockIRijksDataRepository.getRijksItems(any()))
        .thenAnswer((_) async => Right(listRijksItems));

    // act
    final result =
        await usecase(NextPageRijksItemsParams(pageNumber: pageNumber));

    // assert
    expect(result, Right(listRijksItems));
    verify(() => mockIRijksDataRepository.getRijksItems(pageNumber));
    verifyNoMoreInteractions(mockIRijksDataRepository);
  });
}
