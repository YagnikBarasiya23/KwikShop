// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kwikshop/components/retailer_widget.dart';

class SearchBar extends SearchDelegate {
  final List<String> suggestions = [
    'Dmart',
    'Frozen World',
    'Vikram Provision Store',
    'Krushna General Store',
    'Osia Mart',
    'All in one General Store',
    'Shiv Provision Store',
    'Golden Supermarket',
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
    if (query == 'Dmart' || suggestion[0] == 'Dmart') {
      index = 0;
    } else if (query == 'Frozen World' || suggestion[0] == 'Frozen World') {
      index = 4;
    } else if (query == 'Krushna General Store' ||
        suggestion[0] == 'Krushna General Store') {
      index = 1;
    } else if (query == 'Vikram Provision Store' ||
        suggestion[0] == 'Vikram Provision Store') {
      index = 2;
    } else if (query == 'Osia Mart' || suggestion[0] == 'Osia Mart') {
      index = 5;
    } else if (query == 'All in one General Store' ||
        suggestion[0] == 'All in one General Store') {
      index = 6;
    } else if (query == 'Shiv Provision Store' ||
        suggestion[0] == 'Shiv Provision Store') {
      index = 7;
    } else if (query == 'JayMataji General Store' ||
        suggestion[0] == 'JayMataji General Store') {
      index = 9;
    }
    recent.add(query);
    return RetailerWidget(index: index, width: 380);
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
