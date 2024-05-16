import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task/features/upload/presentation/provider/upload_provider.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: mq.height * .03, bottom: mq.height * .05),
      children: [
        const Text(
          'Pick a Profile Picture',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: mq.height * .02),
        Consumer<UploadProvider>(
          builder: (context, imageProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15)),
                    onPressed: () async {
                      await imageProvider
                          .pickImage(ImageSource.gallery)
                          .then((value) {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      });
                    },
                    child: Image.asset('assets/images/gallery.png')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: Size(mq.width * .3, mq.height * .15)),
                    onPressed: () async {
                      await imageProvider
                          .pickImage(ImageSource.camera)
                          .then((value) {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      });
                    },
                    child: Image.asset('assets/images/camera.png')),
              ],
            );
          },
        ),
      ],
    );
  }
}
