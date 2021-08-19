import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rijksmuseumapp/app/core/errors/exceptions.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/models/rijks_item_details_model.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/models/rijks_item_model.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/repositories/rijks_data_repository.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';

import '../../../../../mocks.dart';

void main() {
  late RijksDataRepository repository;
  late MockIRijksDataSource mockRijksDataSource;

  setUp(() {
    mockRijksDataSource = MockIRijksDataSource();
    repository = RijksDataRepository(rijksDataSource: mockRijksDataSource);
  });

  group('getRijksItems', () {
    final pageNumber = 1;
    final listRijksItemModels = List<RijksItemModel>.generate(
      5,
      (i) => RijksItemModel(
        id: '1111',
        objectNumber: '1111',
        title: 'test',
        headerImageUrl: 'test',
        principalOrFirstMaker: 'test',
      ),
    );
    final List<RijksItem> listRijksItems = listRijksItemModels;

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRijksDataSource.getPageWithRijksItems(any()))
          .thenAnswer((_) async => listRijksItemModels);

      // act
      final result = await repository.getRijksItems(pageNumber);

      // assert
      verify(() => mockRijksDataSource.getPageWithRijksItems(pageNumber));
      expect(result, equals(Right(listRijksItems)));
    });

    test(
        'should return server failure when the call to remote source is unsuccessful',
        () async {
      // arrange
      when(() => mockRijksDataSource.getPageWithRijksItems(any()))
          .thenThrow(ServerException());

      // act
      final result = await repository.getRijksItems(pageNumber);

      // assert
      verify(() => mockRijksDataSource.getPageWithRijksItems(pageNumber));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('getRijksItemDetails', () {
    final objectNumber = '1111';
    final rijksItemDetailsModel = RijksItemDetailsModel(
        objectNumber: '1111',
        title: 'test',
        description: 'test',
        webImageUrl: 'test');
    final RijksItemDetails rijksItemDetails = rijksItemDetailsModel;

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRijksDataSource.getRijksItemDetails(any()))
          .thenAnswer((_) async => rijksItemDetailsModel);

      // act
      final result = await repository.getRijksItemDetails(objectNumber);

      // assert
      verify(() => mockRijksDataSource.getRijksItemDetails(objectNumber));
      expect(result, equals(Right(rijksItemDetails)));
    });

    test(
        'should return server failure when the call to remote source is unsuccessful',
        () async {
      // arrange
      when(() => mockRijksDataSource.getRijksItemDetails(any()))
          .thenThrow(ServerException());

      // act
      final result = await repository.getRijksItemDetails(objectNumber);

      // assert
      verify(() => mockRijksDataSource.getRijksItemDetails(objectNumber));
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
