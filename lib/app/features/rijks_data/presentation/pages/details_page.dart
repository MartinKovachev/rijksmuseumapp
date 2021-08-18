import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/bloc/details_page/rijks_item_details_bloc.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/widgets/details_page/image.dart';
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<RijksItemDetailsBloc, RijksItemDetailsState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is Loaded) {
              return Column(
                children: [
                  DetailsImage(item: state.item),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.item.title,
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(
                              8.0,
                              0.0,
                              8.0,
                              8.0,
                            ),
                            child: Text(
                              state.item.description,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
    );
  }
}
