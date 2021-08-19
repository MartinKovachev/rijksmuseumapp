// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import '../core/util/connectivity/connectivity_cubit.dart' as _i5;
import '../features/rijks_data/data/datasources/rijks_data_source.dart' as _i6;
import '../features/rijks_data/data/repositories/rijks_data_repository.dart'
    as _i8;
import '../features/rijks_data/domain/repositories/i_rijks_data_repository.dart'
    as _i7;
import '../features/rijks_data/domain/usecases/get_next_page_rijks_items.dart'
    as _i9;
import '../features/rijks_data/domain/usecases/get_rijks_item_details.dart'
    as _i10;
import '../features/rijks_data/presentation/bloc/details_page/rijks_item_details_bloc.dart'
    as _i11;
import '../features/rijks_data/presentation/bloc/home_page/rijks_items_bloc.dart'
    as _i12;
import 'register_module.dart' as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.Client>(() => registerModule.httpClient);
  gh.lazySingleton<_i4.Connectivity>(() => registerModule.connectivity);
  gh.factory<_i5.ConnectivityCubit>(
      () => _i5.ConnectivityCubit(connectivity: get<_i4.Connectivity>()));
  gh.factory<_i6.IRijksDataSource>(
      () => _i6.RijksDataSource(httpClient: get<_i3.Client>()));
  gh.factory<_i7.IRijksDataRepository>(() =>
      _i8.RijksDataRepository(rijksDataSource: get<_i6.IRijksDataSource>()));
  gh.factory<_i9.GetNextPageRijksItems>(() =>
      _i9.GetNextPageRijksItems(repository: get<_i7.IRijksDataRepository>()));
  gh.factory<_i10.GetRijksItemDetails>(() =>
      _i10.GetRijksItemDetails(repository: get<_i7.IRijksDataRepository>()));
  gh.factory<_i11.RijksItemDetailsBloc>(() => _i11.RijksItemDetailsBloc(
      getRijksItemDetails: get<_i10.GetRijksItemDetails>()));
  gh.factory<_i12.RijksItemsBloc>(() =>
      _i12.RijksItemsBloc(getRijksItems: get<_i9.GetNextPageRijksItems>()));
  return get;
}

class _$RegisterModule extends _i13.RegisterModule {}
