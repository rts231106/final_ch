import 'package:final_ch/constatns/gaps.dart';
import 'package:final_ch/constatns/sizes.dart';
import 'package:final_ch/features/navigation/view/MoodTrackerScreen.dart';
import 'package:final_ch/features/navigation/view/main_navigation_screen.dart';
import 'package:final_ch/features/navigation/viewmodel/upload_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  late TextEditingController _textController;
  int? _selectedIconCode; // iconCode를 int로 저장

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  void _selectIcon(IconData icon) {
    setState(() {
      _selectedIconCode = icon.codePoint; // icon의 codePoint를 저장
    });
  }

Future<void> _submitPost(BuildContext context, WidgetRef ref) async {
  if (_textController.text.isNotEmpty && _selectedIconCode != null) {
    await ref.read(uploadPostViewModelProvider.notifier).uploadPost(
      _textController.text,
      IconData(_selectedIconCode!),
      context,
    );
    // 업로드가 완료되었으면 홈 화면으로 리다이렉트
    if (mounted) {
      context.go('/home');
    }
  }
}

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(uploadPostViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v32,
              const Text(
                "How do you feel?",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.v12,
              TextField(
                controller: _textController,
                maxLines: 4,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Write it down here",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: Sizes.size14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      Sizes.size5,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      Sizes.size5,
                    ),
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                cursorColor: Colors.white,
              ),
              Gaps.v20,
              const Text(
                "What's your mood?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v14,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () =>
                        _selectIcon(Icons.sentiment_satisfied_outlined),
                    icon: FaIcon(
                      Icons.sentiment_satisfied_outlined,
                      color: _selectedIconCode ==
                              Icons.sentiment_satisfied_outlined.codePoint
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        _selectIcon(Icons.sentiment_dissatisfied_outlined),
                    icon: FaIcon(
                      Icons.sentiment_dissatisfied_outlined,
                      color: _selectedIconCode ==
                              Icons.sentiment_dissatisfied_outlined.codePoint
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        _selectIcon(Icons.sentiment_very_dissatisfied_outlined),
                    icon: FaIcon(
                      Icons.sentiment_very_dissatisfied_outlined,
                      color: _selectedIconCode ==
                              Icons.sentiment_very_dissatisfied_outlined
                                  .codePoint
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        _selectIcon(Icons.sentiment_very_satisfied_outlined),
                    icon: FaIcon(
                      Icons.sentiment_very_satisfied_outlined,
                      color: _selectedIconCode ==
                              Icons.sentiment_very_satisfied_outlined.codePoint
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        _selectIcon(Icons.sentiment_neutral_outlined),
                    icon: FaIcon(
                      Icons.sentiment_neutral_outlined,
                      color: _selectedIconCode ==
                              Icons.sentiment_neutral_outlined.codePoint
                          ? Colors.pink
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
              Gaps.v80,
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size96 + Sizes.size56,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // 버튼의 모서리 둥글기 설정
                    ),
                  ),
                   onPressed: state is AsyncLoading ? null : () => _submitPost(context, ref),
                  child: state is AsyncLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Post',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
