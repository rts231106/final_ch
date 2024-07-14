import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ch/features/navigation/model/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostRepository{ 
   final FirebaseFirestore _db = FirebaseFirestore.instance;



//upload a post
  Future<void> upLoadPostData(PostModel data) async {
    await _db.collection("post").add(data.toJson());
  }

    Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts() {
    return _db
        .collection("post")
        .orderBy("timestamp", descending: true)
        .get();
  }

}
final postRepo = Provider((ref) => PostRepository());