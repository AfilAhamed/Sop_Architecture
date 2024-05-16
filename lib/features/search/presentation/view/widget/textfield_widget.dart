import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/search_provider.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchUserProvider>(
      builder: (context, searchprovider, child) {
        return Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: searchprovider.searchController,
              onChanged: (value) {
                // homeProvider.search(value);
                EasyDebounce.debounce(
                    'my-debouncer', const Duration(milliseconds: 500), () {
                  if (value.isNotEmpty) {
                    searchprovider.clearData();
                    searchprovider.getSearchUsers();
                  } else {
                    searchprovider.clearData();
                  }
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search by name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
