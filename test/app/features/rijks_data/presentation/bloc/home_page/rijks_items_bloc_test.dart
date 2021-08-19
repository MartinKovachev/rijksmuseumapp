import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rijksmuseumapp/app/core/const/failure_messages.dart';
import 'package:rijksmuseumapp/app/core/errors/failures.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/usecases/get_page_with_rijks_items.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/bloc/home_page/rijks_items_bloc.dart';

import '../../../../../../mocks.dart';

void main() {
  late RijksItemsBloc bloc;
  late MockGetPageWithRijksItems mockGetPageWithRijksItems;

  setUpAll(() {
    registerFallbackValue<NextPageRijksItemsParams>(
        NextPageRijksItemsParams(pageNumber: 1));
  });

  setUp(() {
    mockGetPageWithRijksItems = MockGetPageWithRijksItems();
    bloc = RijksItemsBloc(getRijksItems: mockGetPageWithRijksItems);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be Loading', () {
    // assert
    expect(bloc.state, Loading());
  });

  group('GetPageWithRijksItems', () {
    final items = List<RijksItem>.generate(
      5,
      (i) => RijksItem(
        objectNumber: '1111',
        title: 'test',
        headerImageUrl: 'test',
        principalOrFirstMaker: 'test',
      ),
    );

    test(
      'should emit Loaded state when GetNextPageRijksItemsEvent is added and data is gotten successfully',
      () async {
        // arrange
        when(() => mockGetPageWithRijksItems(any()))
            .thenAnswer((_) async => Right(items));
        // assert later
        expectLater(bloc.stream, emits(Loaded(items: items)));
        // act
        bloc.add(GetNextPageRijksItemsEvent());
      },
    );

    test(
      'should emit Error state when GetNextPageRijksItemsEvent is added and there is a ServerFailure',
      () async {
        // arrange
        when(() => mockGetPageWithRijksItems(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        expectLater(bloc.stream,
            emits(Error(message: FailureMessages.SERVER_FAILURE_MESSAGE)));
        // act
        bloc.add(GetNextPageRijksItemsEvent());
      },
    );
  });
}
