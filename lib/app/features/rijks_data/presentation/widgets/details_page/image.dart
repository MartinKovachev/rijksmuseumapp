import 'package:flutter/material.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';

class DetailsImage extends StatelessWidget {
  final RijksItemDetails item;

  const DetailsImage({
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
          loadingBuilder: (BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes !=
                    null
                    ? loadingProgress
                    .cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        )
            : Text('No image'),
      ),
    );
  }
}