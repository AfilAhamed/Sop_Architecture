import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/features/upload/repo/i_upload_impl.dart';
import 'package:task/features/home/data/model/user_model.dart';

class UploadProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String imagePath = "";
  bool isLoading = false;

  // add user
  Future<void> addUser(UserModel user) async {
    await AddUserRepository().addUsers(user);
    notifyListeners();
  }

  //set user profile picture
  Future<void> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imagePath = image.path;
      notifyListeners();
    }
  }

  // user data from textfields
  void clearDatas() {
    nameController.clear();
    ageController.clear();
    imagePath = '';
    notifyListeners();
  }
}
