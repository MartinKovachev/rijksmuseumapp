import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/usecases/get_rijks_item_details.dart';

import '../../../../../mocks.dart';

void main() {
  late GetRijksItemDetails usecase;
  late MockIRijksDataRepository mockIRijksDataRepository;

  setUp(() {
    mockIRijksDataRepository = MockIRijksDataRepository();
    usecase = GetRijksItemDetails(repository: mockIRijksDataRepository);
  });

  final objectNumber = '1111';
  final rijksItemDetails = RijksItemDetails(
    objectNumber: '1111',
    title: 'test',
    description: 'test',
    webImageUrl: 'test',
  );

  test(
      'should get rijks item with details for the passed objectNumber from the repository',
      () async {
    // arrange
    when(() => mockIRijksDataRepository.getRijksItemDetails(any()))
        .thenAnswer((_) async => Right(rijksItemDetails));

    // act
    final result = await usecase(ItemDetailsParams(objectNumber: objectNumber));

    // assert
    expect(result, Right(rijksItemDetails));
    verify(() => mockIRijksDataRepository.getRijksItemDetails(objectNumber));
    verifyNoMoreInteractions(mockIRijksDataRepository);
  });
}
