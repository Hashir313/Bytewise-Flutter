import 'dart:io';

import 'package:e_commercw_app/constants/colors.dart';
import 'package:e_commercw_app/models/user_model/user_model.dart';
import 'package:e_commercw_app/provider/app_provider.dart';
import 'package:e_commercw_app/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  File? image;

  void takePicture() async {
    final XFile? value = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors().primaryColor.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: "Zolina Bold",
            color: AppColors().primaryColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(
            Icons.arrow_back_ios,
            color: AppColors().primaryColor,
          ),
        ),
        backgroundColor: AppColors().buttonColor.withOpacity(0.7),
      ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            image == null
                ? CircleAvatar(
                    radius: 70,
                    backgroundColor: AppColors().buttonColor,
                    child: IconButton(
                      onPressed: () {
                        takePicture();
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 40.0,
                        color: AppColors().primaryColor,
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: 70,
                    backgroundImage: FileImage(image!),
                  ),
            const SizedBox(
              height: 80.0,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: appProvider.getUserInformation?.userName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: AppColors().primaryColor,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: AppColors().buttonColor,
                    width: 2.0,
                  ),
                ),
                focusColor: AppColors().buttonColor,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            SmallButtonWidget(
              onTap: () async {
                UserModel? userInformation = appProvider.getUserInformation;
                if (userInformation != null) {
                  UserModel userModel = userInformation.copyWith(
                    userName: nameController.text.toString(),
                  );
                  appProvider.updateUserInfo(userModel, image, context);
                }
              },
              buttonText: "Update",
              loading: false,
            ),
          ],
        ),
      ),
    );
  }
}
