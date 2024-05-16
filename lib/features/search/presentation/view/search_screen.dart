import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task/features/search/presentation/provider/search_provider.dart';

import 'widget/textfield_widget.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 229, 229, 229),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: const Text(
              "Search User",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            leading: Consumer<SearchUserProvider>(
                builder: (context, searchProvider, child) {
              return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    searchProvider.searchController.clear();
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded));
            }),
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<SearchUserProvider>(
                builder: (context, searchProvider, child) {
              return Column(
                children: [
                  const SearchForm(),
                  Expanded(
                      child: searchProvider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : searchProvider.userSearchList.isEmpty
                              ? Center(
                                  child: Text(
                                    searchProvider.searchController.text.isEmpty
                                        ? ""
                                        : 'No User Found',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                )
                              : ListView.builder(
                                  controller: searchProvider.scrollController,
                                  itemCount:
                                      searchProvider.userSearchList.length,
                                  itemBuilder: (context, index) {
                                    final data =
                                        searchProvider.userSearchList[index];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 1.5),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            elevation: 1,
                                            color: Colors.white,
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 9,
                                                      horizontal: 10),
                                              leading: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: Image.network(
                                                  data.image,
                                                  fit: BoxFit.cover,
                                                ).image,
                                              ),
                                              title: Text(
                                                data.name,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: mq.height * 0.007,
                                                  ),
                                                  Text(
                                                    'Age: ${data.age}',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black87),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (index ==
                                                searchProvider
                                                        .userSearchList.length -
                                                    1 &&
                                            searchProvider.isMoreDataLoading)
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          )
                                      ],
                                    );
                                  },
                                ))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
