import 'package:flutter/material.dart';
import 'package:kwikshop/features/home/presentation/widgets/store_card.dart';

import '../../../../injection_container.dart';
import '../../../home/domain/entities/store.dart';
import '../../../home/domain/usecase/store_usecase.dart';
import '../../domain/entities.dart';

class SearchButton extends SearchDelegate {
  final List<Store> stores =
      storeInjection.get<StoreUseCase>().call(params: Categories.all);
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    List<Store> matchStores = [];
    for (var store in stores) {
      if (store.storeName.toLowerCase().contains(query.toLowerCase())) {
        matchStores.add(store);
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ListView.builder(
        itemBuilder: (context, index) => StoreCard(store: matchStores[index]),
        itemCount: matchStores.length,
        shrinkWrap: true,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var store in stores) {
      if (store.storeName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(store.storeName);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.store),
        title: Text(
          matchQuery[index],
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black),
        ),
      ),
      itemCount: matchQuery.length,
      shrinkWrap: true,
    );
  }
}
