import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? email;
  String? name;
  String? image;

  Post({this.email, this.name, this.image});

  factory Post.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String? email = data['email'];
    String? name = data['name'];
    String? image = data['postImage'];
    return Post(email: email, name: name, image: image);
  }
}
