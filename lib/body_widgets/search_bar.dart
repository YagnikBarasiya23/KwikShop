// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kwikshop/components/retailer_widget.dart';

class SearchBar extends SearchDelegate {
  final List<String> suggestions = [
    'Emart',
    'Frozen World',
    'Vikram Brothers',
    'Krushna General Store',
    'Dev general store',
    'All in one general store',
    'Umart',
    'Shiv Provision Store',
    'Golden Supermarket',
    'JayMataji General Store',
  ];
  List<String> recent = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          CupertinoIcons.clear,
          color: Colors.black,
        ));
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          CupertinoIcons.arrow_left,
          color: Colors.black,
        ));
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    late int index;
    final suggestion = query.isEmpty
        ? recent
        : suggestions.where((element) => element.startsWith(query)).toList();
    if (query == 'Emart' || suggestion[0] == 'Emart') {
      index = 0;
    } else if (query == 'Frozen World' || suggestion[0] == 'Frozen World') {
      index = 1;
    } else if (query == 'Krushna General Store' ||
        suggestion[0] == 'Krushna General Store') {
      index = 2;
    } else if (query == 'Vikram Brothers' ||
        suggestion[0] == 'Vikram Brothers') {
      index = 3;
    } else if (query == 'Dev general store' ||
        suggestion[0] == 'Dev general store') {
      index = 4;
    } else if (query == 'All in one general store' ||
        suggestion[0] == 'All in one general store') {
      index = 5;
    } else if (query == 'Umart' || suggestion[0] == 'Umart') {
      index = 6;
    } else if (query == 'Shiv Provision Store' ||
        suggestion[0] == 'Shiv Provision Store') {
      index = 7;
    } else if (query == 'Golden Supermarket' ||
        suggestion[0] == 'Golden Supermarket') {
      index = 8;
    } else if (query == 'JayMataji General Store' ||
        suggestion[0] == 'JayMataji General Store') {
      index = 9;
    }
    recent.add(query);
    return RetailerWidget(index: index, height: 200, width: 380);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? recent
        : suggestions.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showResults(context);
          },
          leading: const Icon(CupertinoIcons.bag_fill),
          title: Text(suggestion[index]),
        );
      },
      itemCount: suggestion.length,
    );
  }
}
