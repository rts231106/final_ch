import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ch/features/authentication/ViewModel/users_view_model.dart';
import 'package:final_ch/features/authentication/repos/Auth_repo.dart';
import 'package:final_ch/features/navigation/model/post_model.dart';
import 'package:final_ch/features/navigation/repos/post_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadPostViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepository _postRepository;
  List<PostModel> _list = [];

  @override
  FutureOr<List<PostModel>> build() async {
    _postRepository = ref.read(postRepo);
    final result = await _postRepository.fetchPosts();
    final newList = result.docs.map(
      (doc) => PostModel.fromJson(
        doc.data(),
      ),
    );
    _list = newList.toList();
    return _list;
  }

  Future<void> uploadPost(
      String text, IconData icon, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();

      await _postRepository.upLoadPostData(
        PostModel(
          text: text,
          creatorUid: user!.uid,
          iconCode: icon.codePoint,
          timestamp:
              Timestamp.now(), // Add this if you want to store the timestamp
        ),
      );
state = AsyncValue.data([...state.value ?? [], PostModel(text: text, creatorUid: user.uid, iconCode: icon.codePoint, timestamp: Timestamp.now())]);
    }
  }
}

final uploadPostViewModelProvider =
    AsyncNotifierProvider<UploadPostViewModel, List<PostModel>>(
        () => UploadPostViewModel());
