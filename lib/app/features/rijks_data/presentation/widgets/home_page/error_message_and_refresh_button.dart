import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/bloc/home_page/rijks_items_bloc.dart';

class ErrorMessageAndRefreshButton extends StatelessWidget {
  final String message;

  const ErrorMessageAndRefreshButton({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          IconButton(
            onPressed: () => BlocProvider.of<RijksItemsBloc>(context).add(
              GetPageRijksItemsEvent(),
            ),
            icon: Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
          ),
        ],
      ),
    );
  }
}
