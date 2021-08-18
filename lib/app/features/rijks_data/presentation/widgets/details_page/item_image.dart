import 'package:flutter/material.dart';
import 'package:rijksmuseumapp/app/core/shared_widgets/loader.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';

class ItemImage extends StatelessWidget {
  final RijksItemDetails item;

  const ItemImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: InteractiveViewer(
        child: item.webImageUrl != null
            ? Image.network(
                item.webImageUrl!,
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Loader(loadingProgress: loadingProgress);
                },
              )
            : Text('No image'),
      ),
    );
  }
}
