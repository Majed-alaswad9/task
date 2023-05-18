import 'package:flutter/material.dart';

import '../../features/photo/presentation/pages/search_photo_page.dart';

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    return SearchPhotoPage(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      'office',
      'orange',
      'chair',
      'apple',
      'usa',
    ];
    return ListView.separated(
        itemCount: suggestions.length,
        separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
        itemBuilder: (context, index) => ListTile(
              title: Text(suggestions[index]),
              onTap: () {
                query = suggestions[index];
              },
            ));
  }
}
