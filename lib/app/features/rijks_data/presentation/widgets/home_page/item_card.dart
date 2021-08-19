import 'package:flutter/material.dart';
import 'package:rijksmuseumapp/app/core/shared_widgets/loader.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/router/app_routes.dart';

class ItemCard extends StatelessWidget {
  final RijksItem item;

  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.DETAILS_PAGE,
          arguments: {'objectNumber': item.objectNumber},
        );
      },
      splashColor: Colors.blue,
      child: SizedBox(
        height: 250,
        width: double.maxFinite,
        child: Card(
          color: Colors.black,
          elevation: 5.0,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            children: [
              SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: item.headerImageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          item.headerImageUrl!,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Loader(loadingProgress: loadingProgress);
                          },
                        ),
                      )
                    : const Center(
                      child: Text(
                          'No image',
                          style: TextStyle(color: Colors.white),
                        ),
                    ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 19.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
