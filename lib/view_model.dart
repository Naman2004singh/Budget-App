import 'package:budget_app/components/dialogbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final viewModel = ChangeNotifierProvider.autoDispose<ViewModel>(
  (ref) => ViewModel(),
);

class ViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool isSignedIn = false;
  bool isObscure = true;
  var logger = Logger();

  // check if the user is signed in or signed out
  Future<void> isLoggedIn() async {
    await _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isSignedIn = false;
      } else {
        isSignedIn = true;
      }
    }); // stream of any authentication change in the app
    notifyListeners();
  }

  toggleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  //Authentication
  //Register new user
  Future<void> RegisterUser(
      BuildContext context, String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d("Registration successful"))
        .onError((error, StackTrace) {
      logger.d("Registration error:$error");
      DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }

  //Login the user
  Future<void> LoginUser(
      BuildContext context, String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) => logger.d("Login successgul"),
        )
        .onError(
      (error, stackTrace) {
        logger.d("Login error: $error");
        DialogBox(
            context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
      },
    );
  }
}
