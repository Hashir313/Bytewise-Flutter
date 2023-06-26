import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pic_sharing_app/model/image_picker/pick_image.dart';
import 'package:pic_sharing_app/resources/utils/colors.dart';
import 'package:pic_sharing_app/resources/utils/utils.dart';
import 'package:pic_sharing_app/resources/widget/button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadPicture extends StatefulWidget {
  const UploadPicture({Key? key}) : super(key: key);

  @override
  State<UploadPicture> createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final captionController = TextEditingController();
  bool captionInputColor = false;
  bool loading = false;

  void addPost() async {
    setState(() {
      loading = true;
    });

    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref('/Post/' + DateTime.now().millisecondsSinceEpoch.toString());

    firebase_storage.UploadTask uploadTask = reference.putData(_image!);
    Future.value(uploadTask).then((value) async {
      var newUrl = await reference.getDownloadURL();

      User userID = auth.currentUser!;
      firestore.collection('Post').doc(userID.uid).set({
        'caption': captionController.text.toString(),
        'postImage': newUrl.toString(),
        'uid': userID.uid,
      });
      Utils().showToastMessage('Post Added');
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().showToastMessage(error.toString());
    });
  }


  //image picker
  Uint8List? _image;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  final databaseRef = FirebaseDatabase.instance.ref('Picture_Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Upload Picture'),
        backgroundColor: AppColors().primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: captionInputColor == true
                  ? AppColors().primaryColor
                  : Colors.transparent,
              child: TextFormField(
                maxLines: 4,
                cursorColor: AppColors().primaryColor,
                controller: captionController,
                onTapOutside: (value) {
                  setState(() {
                    captionInputColor = false;
                  });
                },
                onTap: () {
                  setState(() {
                    captionInputColor = true;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'What\'s in your mind?',
                  hintStyle: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      color: captionInputColor == true
                          ? AppColors().primaryColor
                          : Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                          color: AppColors().primaryColor, width: 2.0)),
                ),
              ),
            ),
          ),
          //image picker
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Center(
              child: InkWell(
                onTap: () => selectImage(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width * 1,
                  child: _image != null
                      ? Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(
                                    _image!,
                                  ),
                                  fit: BoxFit.contain)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Icon(
                            Icons.add_a_photo_rounded,
                            color: AppColors().primaryColor,
                          ),
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100.0,
          ),
          ButtonWidget(
              loading: loading, buttonText: 'Post', onTap: () => addPost())
        ],
      ),
    );
  }
}
