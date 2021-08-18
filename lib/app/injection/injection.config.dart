// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../features/rijks_data/data/datasources/rijks_data_source.dart' as _i3;
import '../features/rijks_data/data/repositories/rijks_data_repository.dart'
    as _i5;
import '../features/rijks_data/domain/repositories/i_rijks_data_repository.dart'
    as _i4;
import '../features/rijks_data/domain/usecases/get_next_page_rijks_items.dart'
    as _i6;
import '../features/rijks_data/domain/usecases/get_rijks_item_details.dart'
    as _i7;
import '../features/rijks_data/presentation/bloc/details_page/rijks_item_details_bloc.dart'
    as _i8;
import '../features/rijks_data/presentation/bloc/home_page/rijks_items_bloc.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.IRijksDataSource>(() => _i3.RijksDataSource());
  gh.factory<_i4.IRijksDataRepository>(() =>
      _i5.RijksDataRepository(rijksDataSource: get<_i3.IRijksDataSource>()));
  gh.factory<_i6.GetNextPageRijksItems>(() =>
      _i6.GetNextPageRijksItems(repository: get<_i4.IRijksDataRepository>()));
  gh.factory<_i7.GetRijksItemDetails>(() =>
      _i7.GetRijksItemDetails(repository: get<_i4.IRijksDataRepository>()));
  gh.factory<_i8.RijksItemDetailsBloc>(() => _i8.RijksItemDetailsBloc(
      getRijksItemDetails: get<_i7.GetRijksItemDetails>()));
  gh.factory<_i9.RijksItemsBloc>(() =>
      _i9.RijksItemsBloc(getRijksItems: get<_i6.GetNextPageRijksItems>()));
  return get;
}
