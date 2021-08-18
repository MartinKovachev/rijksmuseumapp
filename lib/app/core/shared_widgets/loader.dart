import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final ImageChunkEvent? loadingProgress;

  const Loader({Key? key, this.loadingProgress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.brown,
          value: loadingProgress != null
              ? (loadingProgress!.expectedTotalBytes != null
                  ? loadingProgress!.cumulativeBytesLoaded /
                      loadingProgress!.expectedTotalBytes!
                  : null)
              : null,
        ),
      ),
    );
  }
}
