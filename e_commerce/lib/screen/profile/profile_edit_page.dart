import 'dart:io';

import 'package:e_commerce/utils/appConstant/app_constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  XFile? pickedImage;
  File? selectedFile;
  CroppedFile? croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Start: upar
            end: Alignment.bottomCenter, // Stop: neeche
            colors: [AppColor.mainColor.withValues(alpha: 0.7), AppColor.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                // STEP 1 : PICK THE IMAGE
                pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedImage != null) {
                  // STEP 1 : IF IMAGE IS != NULL THEN CROPPED IMAGE
                  croppedFile = await ImageCropper().cropImage(
                    sourcePath: pickedImage!.path,
                  );

                  // STEP 1 : CROPPED IMAGE != NULL

                  if (croppedFile != null) {
                    selectedFile = File(pickedImage!.path);

                    // STEP 1 : CREATE FIREBASE INSTANCE

                    FirebaseStorage storage = FirebaseStorage.instance;
                    // STEP 1 : CREATE STORAGE REFERENCE

                    Reference ref = storage.ref();
                    // STEP 1 : CREATE IMAGE STOAGE NAME FILE FOR FIREBASE

                    Reference imagRef = ref.child("profile_pics").child("{}");
                    // STEP 1 : CONVERT TO BYTE

                    var imageByte = selectedFile!.readAsBytesSync();

                    // STEP 1 : UPLOAD IMAGE & LISTEN
                    UploadTask uploadTask = imagRef.putData(imageByte);

                    uploadTask.asStream().listen((event) {});
                  }

                  setState(() {});
                }
              },
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: selectedFile != null
                        ? FileImage(selectedFile!)
                        : const AssetImage('asset/image/app_logo_white.png'),
                  ),
                  color: AppColor.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
