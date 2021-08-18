import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/bloc/home_page/rijks_items_bloc.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/widgets/home_page/item_card.dart';
import 'package:rijksmuseumapp/app/injection/injection.dart';
import 'package:rijksmuseumapp/app/router/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RijksItemsBloc>()..add(GetRijksItemsEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<RijksItemsBloc, RijksItemsState>(
            builder: (context, state) {
              if (state is Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Loaded) {
                return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.DETAILS_PAGE,
                          arguments: {
                            'objectNumber': state.items[index].objectNumber
                          },
                        );
                      },
                      splashColor: Colors.blue,
                      child: ItemCard(item: state.items[index], key: ValueKey(index),),
                    );
                  },
                );
              } else if (state is Error) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text('Oops something happened'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
