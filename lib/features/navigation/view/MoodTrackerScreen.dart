import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ch/features/authentication/View/logInScreen.dart';
import 'package:final_ch/features/authentication/repos/auth_repo.dart';
import 'package:final_ch/features/navigation/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MoodTrackerScreen extends ConsumerStatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends ConsumerState<MoodTrackerScreen> {
  final int _itemCount = 4;

  Future<void> _onRefresh() async {
    // 예시로 2초 후에 RefreshIndicator가 사라지도록 하기 위해 Future.delayed 사용
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('post')
            .orderBy('timestamp', descending: true) // timestamp 필드 기준 내림차순 정렬
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return RefreshIndicator(
            onRefresh: () async {
              // Refresh logic here
            },
            displacement: 50,
            edgeOffset: 20,
            child: ListView.builder(
              itemCount: documents.length + 1,
              itemBuilder: (context, index) {
                if (index < documents.length) {
                  final post = PostModel.fromJson(
                      documents[index].data() as Map<String, dynamic>);
                  final formattedDate =
                      DateFormat('MM-dd HH:mm').format(post.timestamp.toDate());
                  return InkWell(
                    onLongPress: () {
                      // 긴 Press 이벤트 처리: 해당 게시물 삭제
                      FirebaseFirestore.instance
                          .collection('post')
                          .doc(documents[index].id)
                          .delete()
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('게시물이 삭제되었습니다.'),
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('게시물 삭제 중 오류가 발생했습니다: $error'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "mood : ${post.text}",
                            maxLines: 4,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              // Adjust icon retrieval as per your data structure
                              post.getIconWidget(),
                              const SizedBox(width: 8),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: const Text("Log out (iOS)"),
                      textColor: Colors.red,
                      onTap: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            title: const Text("Are you sure?"),
                            content: const Text("Plz dont go"),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("No"),
                              ),
                              CupertinoDialogAction(
                                onPressed: () {
                                  ref.read(authRepo).signOut();
                                  context.go(LoginScreen.routeURL);
                                },
                                isDestructiveAction: true,
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}



            /*ListTile(
            title: const Text("Log out (iOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        ref.read(authRepo).signOut();
                        context.go(LoginScreen.routeURL);
                      },
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          */