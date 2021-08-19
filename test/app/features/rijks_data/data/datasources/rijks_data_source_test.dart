import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rijksmuseumapp/app/core/const/api_endpoints.dart';
import 'package:rijksmuseumapp/app/core/errors/exceptions.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/datasources/rijks_data_source.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/models/rijks_item_details_model.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/models/rijks_item_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late RijksDataSource rijksDataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue<Uri>(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    rijksDataSource = RijksDataSource(httpClient: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String jsonFile) {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(
                fixture(jsonFile), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            }));
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getPageWithRijksItems', () {
    final pageNumber = 1;
    final responseJson = json.decode(fixture('rijks_page_items.json'));
    final listRijksItemModels =
        (responseJson['artObjects'])
            .map<RijksItemModel>(
                (p) => RijksItemModel.fromJson(p as Map<String, dynamic>))
            .toList() as List<RijksItemModel>;

    test(
      'should return List<RijksItemModel> when the response code is 200 (OK)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('rijks_page_items.json');

        // act
        final result = await rijksDataSource.getPageWithRijksItems(pageNumber);

        // assert
        expect(result, equals(listRijksItemModels));
      },
    );

    test(
      'should return ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();

        // act
        final call = rijksDataSource.getPageWithRijksItems;

        // assert
        expect(() => call(pageNumber), throwsA(isA<ServerException>()));
      },
    );
  });

  group('getRijksItemDetails', () {
    final objectNumber = '1111';
    final responseJson = json.decode(fixture('rijks_item_details.json'));
    final rijksItemDetailsModel = RijksItemDetailsModel.fromJson(
        responseJson['artObject'] as Map<String, dynamic>);

    test(
      'should return RijksItemDetailsModel when the response code is 200 (OK)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200('rijks_item_details.json');

        // act
        final result = await rijksDataSource.getRijksItemDetails(objectNumber);

        // assert
        expect(result, equals(rijksItemDetailsModel));
      },
    );

    test(
      'should return ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();

        // act
        final call = rijksDataSource.getRijksItemDetails;

        // assert
        expect(() => call(objectNumber), throwsA(isA<ServerException>()));
      },
    );
  });
}
