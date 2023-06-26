import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadUserImage(File? imageFile) async {
    if (imageFile == null) {
      // Handle the case where imageFile is null
      return Future.error("Image file is null");
    }

    if (!imageFile.existsSync()) {
      // Handle the case where the file does not exist
      return Future.error("Invalid file path");
    }

    String userId = FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot snapshot = await _storage.ref(userId).putFile(imageFile);
    String imageURL = await snapshot.ref.getDownloadURL();
    return imageURL;
  }
}
