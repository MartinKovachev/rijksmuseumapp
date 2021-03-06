import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item_details.dart';

class ItemDetails extends StatelessWidget {
  final RijksItemDetails item;

  const ItemDetails({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: Text(
              item.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(
                8.0,
              ),
              child: Text(
                item.description ?? 'No description',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
