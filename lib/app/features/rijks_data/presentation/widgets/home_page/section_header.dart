import 'package:flutter/material.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';

class SectionHeader extends StatelessWidget {
  final RijksItem item;

  const SectionHeader({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.all(8.0),
      width: double.maxFinite,
      child: Text(
        item.principalOrFirstMaker,
        style: TextStyle(
          fontSize: 21.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
