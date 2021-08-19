import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/data/datasources/rijks_data_source.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/repositories/i_rijks_data_repository.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/usecases/get_page_with_rijks_items.dart';

class MockIRijksDataRepository extends Mock implements IRijksDataRepository {}

class MockIRijksDataSource extends Mock implements IRijksDataSource {}

class MockGetPageWithRijksItems extends Mock implements GetPageWithRijksItems {}

class MockHttpClient extends Mock implements http.Client {}
