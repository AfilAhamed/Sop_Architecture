import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task/features/search/repo/i_search_impl.dart';
import '../../../../general/services/toast_messages.dart';
import '../../../home/data/model/user_model.dart';

class SearchUserProvider extends ChangeNotifier {
  final searchController = TextEditingController();

  SearchUserProvider() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getSearchUsers();
      }
    });
  }
  List<UserModel> userSearchList = [];
  QueryDocumentSnapshot<Object>? lastDocs;
  SearchUserRepository searchUserRepository = SearchUserRepository();
  final ScrollController scrollController = ScrollController();
  bool isMoreDataLoading = true;
  bool isLoading = false;

  //Get Search Users Data
  Future<void> getSearchUsers() async {
    isLoading = true;
    final data = await searchUserRepository
        .getSearchResults(searchController.text.trim());
    data.fold((error) {
      log(error);
      if (error == 'No User Found') {
        // isMoreDataLoading = false; // check

        ToastMessage.showMessage(error, Colors.red);
      } else {
        isMoreDataLoading = false;
        notifyListeners();
      }
    }, (data) {
      if (data.length != 7) {
        isMoreDataLoading = false;
        log(isMoreDataLoading.toString());
      }
      log(isMoreDataLoading.toString());
      userSearchList = [...userSearchList, ...data];
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }

  void clearData() {
    searchUserRepository.lastDocs = null;
    isMoreDataLoading = true;
    userSearchList.clear();
    notifyListeners();
  }
}
