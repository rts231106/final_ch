import 'package:final_ch/features/authentication/View/logInScreen.dart';
import 'package:final_ch/features/authentication/View/signUpScreen.dart';
import 'package:final_ch/features/authentication/repos/auth_repo.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          //subloc == router의 sub location이라는 뜻 
          if (state.subloc != SignUpScreen.routeURL &&
              state.subloc != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeURL,
          builder: (context, state) =>  LoginScreen(),
        ),
      ]);
});
