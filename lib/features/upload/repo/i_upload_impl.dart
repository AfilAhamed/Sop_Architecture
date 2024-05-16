import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../home/data/model/user_model.dart';

class AddUserRepository {
  factory AddUserRepository() {
    return AddUserRepository._();
  }
  AddUserRepository._();

  final firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  //add users to firestore
  Future<void> addUsers(UserModel user) async {
    try {
      final id = firestore.collection('users').doc().id;
      await firestore
          .collection('users')
          .doc(id)
          .set(user.copyWith(docID: id).toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  // add image to firebase storage and return
  Future<String> getUserProfilePicture(File file) async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = firebaseStorage.ref().child('profile_images/$fileName');
    await ref.putFile(File(file.path));
    return await ref.getDownloadURL();
  }
}
