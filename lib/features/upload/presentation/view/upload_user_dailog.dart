import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task/features/home/presentations/provider/home_provider.dart';
import 'package:task/features/upload/presentation/provider/upload_provider.dart';
import 'package:task/features/upload/presentation/view/widgets/loading_dailog.dart';
import '../../../../general/services/search_keywords.dart';
import '../../../../general/services/toast_messages.dart';
import '../../../home/data/model/user_model.dart';
import '../../repo/i_upload_impl.dart';
import 'widgets/image_picker.dart';

class UploadUserDailog extends StatelessWidget {
  const UploadUserDailog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final homeProvider = Provider.of<HomeProvider>(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
        child: SizedBox(
          height: mq.height * .56,
          width: mq.width,
          child: Consumer<UploadProvider>(
            builder: (context, userProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add A New User",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: mq.height * 0.08,
                          backgroundImage: userProvider.imagePath.isEmpty
                              ? null
                              : FileImage(File(userProvider.imagePath)),
                        ),
                        Positioned(
                          left: mq.width * 0.01,
                          top: mq.height * 0.10,
                          child: Transform.rotate(
                            angle: 3.14 / 1,
                            child: ClipRect(
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor: 0.4,
                                child: CircleAvatar(
                                  radius: mq.height * 0.075,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: mq.height * 0.1,
                          left: mq.width * 0.10,
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    context: context,
                                    builder: (builder) {
                                      return const ImagePickerBottomSheet();
                                    });
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 25,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Name",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.005,
                  ),
                  TextFormField(
                    controller: userProvider.nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Age",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: userProvider.ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: mq.width * .28,
                        height: mq.height * 0.046,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 206, 206, 206))),
                            onPressed: () {
                              Navigator.pop(context);
                              userProvider.nameController.clear();
                              userProvider.ageController.clear();
                              userProvider.imagePath = '';
                            },
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey.shade700,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      SizedBox(
                        width: mq.width * 0.03,
                      ),
                      SizedBox(
                        width: mq.width * .27,
                        height: mq.height * 0.046,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.blue.shade600)),
                            onPressed: () async {
                              if (userProvider.nameController.text.isNotEmpty ||
                                  userProvider.ageController.text.isNotEmpty ||
                                  userProvider.imagePath.isNotEmpty) {
                                userProvider.isLoading = true;

                                if (userProvider.isLoading) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const SaveDailog());
                                }
                                final image = await AddUserRepository()
                                    .getUserProfilePicture(
                                        File(userProvider.imagePath));
                                final user = UserModel(
                                    name: userProvider.nameController.text,
                                    age: int.parse(
                                        userProvider.ageController.text.trim()),
                                    image: image,
                                    search: keywordsBuilder(
                                        userProvider.nameController.text));
                                await userProvider.addUser(user).then((value) {
                                  homeProvider.addUserLocaly(user);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                                userProvider.isLoading = false;

                                userProvider.clearDatas();
                              } else {
                                ToastMessage.showMessage(
                                    'Please add all fields', Colors.red);
                                // showSnackBar(context, 'Please add all fields',
                                //     Colors.red);
                              }
                            },
                            child: Text(
                              'Save',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
