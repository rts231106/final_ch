import 'package:final_ch/features/authentication/View/logInScreen.dart';
import 'package:final_ch/features/authentication/repos/Auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MoodTrackerScreen extends ConsumerWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: ListView( 
children: [ 
            ListTile(
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
],
      ),
    );
  }
}
