// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../core/util/register_module.dart' as _i11;
import '../features/rijks_data/data/datasources/rijks_data_source.dart' as _i4;
import '../features/rijks_data/data/repositories/rijks_data_repository.dart'
    as _i6;
import '../features/rijks_data/domain/repositories/i_rijks_data_repository.dart'
    as _i5;
import '../features/rijks_data/domain/usecases/get_next_page_rijks_items.dart'
    as _i7;
import '../features/rijks_data/domain/usecases/get_rijks_item_details.dart'
    as _i8;
import '../features/rijks_data/presentation/bloc/details_page/rijks_item_details_bloc.dart'
    as _i9;
import '../features/rijks_data/presentation/bloc/home_page/rijks_items_bloc.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.Client>(() => registerModule.httpClient);
  gh.factory<_i4.IRijksDataSource>(
      () => _i4.RijksDataSource(httpClient: get<_i3.Client>()));
  gh.factory<_i5.IRijksDataRepository>(() =>
      _i6.RijksDataRepository(rijksDataSource: get<_i4.IRijksDataSource>()));
  gh.factory<_i7.GetNextPageRijksItems>(() =>
      _i7.GetNextPageRijksItems(repository: get<_i5.IRijksDataRepository>()));
  gh.factory<_i8.GetRijksItemDetails>(() =>
      _i8.GetRijksItemDetails(repository: get<_i5.IRijksDataRepository>()));
  gh.factory<_i9.RijksItemDetailsBloc>(() => _i9.RijksItemDetailsBloc(
      getRijksItemDetails: get<_i8.GetRijksItemDetails>()));
  gh.factory<_i10.RijksItemsBloc>(() =>
      _i10.RijksItemsBloc(getRijksItems: get<_i7.GetNextPageRijksItems>()));
  return get;
}

class _$RegisterModule extends _i11.RegisterModule {}
