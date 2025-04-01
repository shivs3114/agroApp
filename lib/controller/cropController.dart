import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class CropController extends GetxController {
  var items = ["Item 1", "Item 2", "Item 3", "Item 4"].obs;

  var imageFile = Rxn<File>(); // Reactive variable to hold the selected/cropped image

  Future<void> pickAndCropImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        imageFile.value = croppedFile; // Update image after cropping
      }
    }
  }

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 2/3,ratioY: 3/4),
    
    
      uiSettings:[ // Ensuring correct UI settings
      AndroidUiSettings(
        toolbarTitle: "Crop Image",
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: "Crop Image",
      ),
    ]
    );

    return cropped != null ? File(cropped.path) : null;
  }
}
