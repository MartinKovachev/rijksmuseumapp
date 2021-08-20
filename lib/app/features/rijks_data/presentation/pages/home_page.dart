import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseumapp/app/core/shared_widgets/loader.dart';
import 'package:rijksmuseumapp/app/core/util/connectivity/connectivity_cubit.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/bloc/home_page/rijks_items_bloc.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/widgets/home_page/error_message_and_refresh_button.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/widgets/home_page/items_list.dart';
import 'package:rijksmuseumapp/app/injection/injection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RijksItemsBloc>()..add(GetPageRijksItemsEvent()),
      child: BlocListener(
        bloc: getIt<ConnectivityCubit>(),
        listener: (context, state) {
          if (state is Connected) {
            _showSnackBar('Connected to internet');
          } else if (state is Disconnected) {
            _showSnackBar('Disconnected from internet');
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: _buildAppBar(),
          body: BlocBuilder<RijksItemsBloc, RijksItemsState>(
            builder: (context, state) {
              if (state is Loading) {
                return const Loader();
              } else if (state is Loaded) {
                return ItemsList(items: state.items);
              } else if (state is Error) {
                return ErrorMessageAndRefreshButton(message: state.message);
              } else {
                return const Center(
                  child: Text('Oops something happened'),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 10.0,
      title: const Text(
        'Rijks Museum',
        style: TextStyle(fontSize: 24.0),
      ),
      centerTitle: true,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
