import 'package:final_ch/constatns/gaps.dart';
import 'package:final_ch/constatns/sizes.dart';
import 'package:final_ch/features/authentication/View/signUpScreen.dart';
import 'package:final_ch/features/authentication/ViewModel/login_view_model.dart';
import 'package:final_ch/features/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String routeName = "login";
  static String routeURL = "/login";

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
              context,
            );
        // context.goNamed(InterestsScreen.routeName);
      }
    }
  }

  void _onSignUpTap(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_fire_department_sharp,
              color: Colors.red,
            ),
            Text("MOOD"),
            Icon(
              Icons.local_fire_department_sharp,
              color: Colors.red,
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size60,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v96,
                Gaps.v36,
                const Center(
                  child: Text(
                    "Welcome!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Gaps.v28,
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your email";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['email'] = newValue;
                    }
                  },
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  cursorColor: Colors.white,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your password";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: FormButton(
                    disabled: ref.watch(loginProvider).isLoading,
                    label: "Enter",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.black,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
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
