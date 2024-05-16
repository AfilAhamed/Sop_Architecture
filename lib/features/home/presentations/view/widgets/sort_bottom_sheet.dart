import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task/features/home/presentations/provider/home_provider.dart';
import 'package:task/general/core/sort_enum.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<HomeProvider>(builder: (context, sortProvider, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Sort',
                style: GoogleFonts.montserrat(
                    fontSize: 19,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700),
              ),
            ),
            RadioListTile(
              title: Text(
                'All',
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              value: AgeType.all,
              groupValue: sortProvider.selectedValue,
              onChanged: (value) {
                sortProvider.clearData();
                sortProvider.changeValue(value!);

                sortProvider.getUsers(value);
              },
            ),
            RadioListTile(
              title: Text(
                'Age: Elder',
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              value: AgeType.elder,
              groupValue: sortProvider.selectedValue,
              onChanged: (value) {
                                // sortProvider.isMoreDataLoading=true;

                sortProvider.clearData();

                sortProvider.changeValue(value!);

                sortProvider.getUsers(value);
              },
            ),
            RadioListTile(
              title: Text(
                'Age: Younger',
                style: GoogleFonts.montserrat(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              value: AgeType.younger,
              groupValue: sortProvider.selectedValue,
              onChanged: (value) {
                // sortProvider.isMoreDataLoading = true;
                sortProvider.clearData();

                sortProvider.changeValue(value!);

                sortProvider.getUsers(value);
              },
            ),
            const SizedBox(
              height: 5,
            )
          ],
        );
      }),
    );
  }
}
