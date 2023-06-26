import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pic_sharing_app/model/post.dart';
import 'package:pic_sharing_app/resources/utils/colors.dart';
import 'package:pic_sharing_app/resources/utils/utils.dart';
import 'package:pic_sharing_app/view/auth/login.dart';
import 'package:pic_sharing_app/view/home/upload_picture.dart';

Stream<List<Post>> getPostsStream() {
  return FirebaseFirestore.instance.collection('Post').snapshots().map(
      (querySnapshot) =>
          querySnapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: AppColors().primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          const SizedBox(
            width: 10.0,
          ),
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                Utils().showToastMessage('Logout successfully');
              }).onError((error, stackTrace) {
                Utils().showToastMessage('Failed to logout');
              });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
            color: AppColors().primaryColor,
            borderRadius: BorderRadius.circular(30.0)),
        alignment: Alignment.bottomLeft,
        child: Row(
          children: [
            TextButton.icon(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadPicture())),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  'Add Post',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      body: StreamBuilder<List<Post>>(
        stream: getPostsStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final posts = snapshot.data!;
          return Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 1,
                    children: List.generate(posts.length, (index) {
                      final image = posts[index].image ?? '';
                      return Column(
                        children: [
                          Row(children: [
                           CircleAvatar()
                          ],),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20.0),
                              height: 350,
                              width: 450,
                              child: Image.network(
                                image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
