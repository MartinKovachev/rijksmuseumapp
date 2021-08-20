import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rijksmuseumapp/app/core/shared_widgets/loader.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/domain/entities/rijks_item.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/bloc/home_page/rijks_items_bloc.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/widgets/home_page/item_card.dart';
import 'package:rijksmuseumapp/app/features/rijks_data/presentation/widgets/home_page/section_header.dart';

class ItemsList extends StatefulWidget {
  final List<RijksItem> items;

  const ItemsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.separated(
        padding: const EdgeInsets.all(6.0),
        controller: _scrollController,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return index >= widget.items.length - 1
              ? const Loader()
              : _sectionHeaderWithItemCardOrItemCard(index);
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 6.0),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      BlocProvider.of<RijksItemsBloc>(context)
          .add(GetPageRijksItemsEvent());
    }

    return false;
  }

  Widget _sectionHeaderWithItemCardOrItemCard(int index) {
    final currentItem = widget.items[index];
    if (index == 0) {
      return _sectionHeaderWithItemCard(currentItem);
    }

    final previousItem = widget.items[index - 1];
    if (currentItem.principalOrFirstMaker != previousItem.principalOrFirstMaker) {
      return _sectionHeaderWithItemCard(currentItem);
    }
    return ItemCard(key: ValueKey<String>(currentItem.id), item: currentItem);
  }

  Column _sectionHeaderWithItemCard(RijksItem currentItem) {
    return Column(
      key: ValueKey<String>(currentItem.id),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(item: currentItem),
        ItemCard(item: currentItem),
      ],
    );
  }
}
