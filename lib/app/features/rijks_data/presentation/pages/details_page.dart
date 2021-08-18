import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseumapp/app/core/shared_widgets/loader.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/bloc/details_page/rijks_item_details_bloc.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/widgets/details_page/item_details.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/widgets/details_page/item_image.dart';
import 'package:rijksmuseumapp/app/injection/injection.dart';

class DetailsPage extends StatefulWidget {
  final String objectNumber;

  const DetailsPage({
    required this.objectNumber,
    Key? key,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RijksItemDetailsBloc>()
        ..add(
          GetRijksItemDetailsEvent(objectNumber: widget.objectNumber),
        ),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: BlocBuilder<RijksItemDetailsBloc, RijksItemDetailsState>(
            builder: (context, state) {
              if (state is Loading) {
                return Loader();
              } else if (state is Loaded) {
                return Column(
                  children: [
                    ItemImage(item: state.item),
                    ItemDetails(item: state.item),
                  ],
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
