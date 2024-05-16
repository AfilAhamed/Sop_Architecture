import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task/features/home/presentations/provider/home_provider.dart';
import 'package:task/features/home/presentations/view/widgets/user_card.dart';
import 'package:task/features/search/presentation/view/search_screen.dart';
import 'package:task/general/utils/app_colors.dart';
import 'widgets/sort_bottom_sheet.dart';
import '../../../upload/presentation/view/upload_user_dailog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffebebeb),
        appBar: AppBar(
          toolbarHeight: mq.height * 0.1,
          backgroundColor: Colors.black,
          leadingWidth: double.infinity,
          leading: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.location_on,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                'Nilambur',
                style: GoogleFonts.montserrat(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
                overflow: TextOverflow.visible,
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 3,
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SearchUserScreen(),
                              )),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5, top: 8),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.search,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "Search Your User",
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: mq.width * 0.02,
                      ),
                      IconButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11))),
                            backgroundColor: MaterialStatePropertyAll(
                                AppColors.primaryColor)),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) =>
                                const SortBottomSheet(), // Sorting Bottom Sheet
                          );
                        },
                        icon: Icon(
                          Icons.filter_list_outlined,
                          color: AppColors.secondaryColor,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Users Lists',
                      style: GoogleFonts.montserrat(
                          fontSize: 17, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                child: Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    return homeProvider.usersList.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            controller: homeProvider.scrollController,
                            itemCount: homeProvider.usersList.length,
                            itemBuilder: (context, index) {
                              final data = homeProvider.usersList[index];
                              return Column(
                                children: [
                                  UserCard(
                                    user: data,
                                  ),
                                  if (index ==
                                          homeProvider.usersList.length - 1 &&
                                      homeProvider.isMoreDataLoading)
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
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
                          );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          height: mq.height * 0.10,
          width: mq.width * 0.15,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              shape: const CircleBorder(),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const UploadUserDailog();
                  },
                );
              },
              child: Icon(
                Icons.add,
                color: AppColors.secondaryColor,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
