import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final int age;
  final String image;
  final Timestamp? createdAt;
  final String? docID;
  final List? search;

  UserModel({
    required this.name,
    required this.age,
    required this.image,
    required this.search,

    this.createdAt,
    this.docID,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      age: map['age'] as int,
      image: map['image'] as String,
      createdAt: map['createdAt'] as Timestamp?,
      docID: map['docID'] != null ? map['docID'] as String : null,
      search: map['search'] as List
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'image': image,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'docID': docID,
      'search':search
    };
  }

  UserModel copyWith({
    String? name,
    int? age,
    String? image,
    String? docID,
  }) {
    return UserModel(
      name: name ?? this.name,
      age: age ?? this.age,
      image: image ?? this.image,
      docID: docID ?? this.docID,
       search: search,
    );
  }
}
