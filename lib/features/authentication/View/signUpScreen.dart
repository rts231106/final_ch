import 'package:final_ch/constatns/gaps.dart';
import 'package:final_ch/constatns/sizes.dart';
import 'package:final_ch/features/authentication/View/logInScreen.dart';
import 'package:final_ch/features/authentication/ViewModel/signup_view_model.dart';
import 'package:final_ch/features/authentication/widget/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static String routeName = "/";
  static String routeURL = "/signup";

  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      _password = _passwordController.text;
    });
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  bool _ispasswordValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    ref.read(signUpForm.notifier).state = {
      "email": _email,
    };
    if (!_ispasswordValid()) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "password": _password};
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _onNextTap() {}

  void _onLoginTap(BuildContext context) {
    // context.go 사용자를 이동 시키는 것인데 Push와 다르게 back 버튼이 없어서 고객이 다시 뒤로 돌아가지 못
    context.push(LoginScreen.routeURL);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Row(
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
            child: Column(
              children: [
                Gaps.v96,
                Gaps.v36,
                const Center(
                  child: Text(
                    "Join!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Gaps.v28,
                TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: _onSubmit,
                  autocorrect: false,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    hintText: "Email",
                    errorText: _isEmailValid(),
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
                ),
                TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: _passwordController,
                  onEditingComplete: _onSubmit,
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
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmit,
                  child: FormButton(
                    disabled: 
                     _email.isEmpty || _isEmailValid() != null && !_ispasswordValid(),
                    label: "Enter",
                  ),
                ),
              ],
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
                  onTap: () => _onLoginTap(context),
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
      ),
    );
  }
}
