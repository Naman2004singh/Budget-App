import 'package:budget_app/components/dialogbox.dart';
import 'package:budget_app/components/materialButton.dart';
import 'package:budget_app/components/textFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final viewModel = ChangeNotifierProvider.autoDispose<ViewModel>(
  (ref) => ViewModel(),
);

class ViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  bool isSignedIn = false;
  bool isObscure = true;
  var logger = Logger();

  List expenseName = [];
  List expenseAmount = [];
  List incomeName = [];
  List incomeAmount = [];

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
          (value) => logger.d("Login successful"),
        )
        .onError(
      (error, stackTrace) {
        logger.d("Login error: $error");
        DialogBox(
            context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
      },
    );
  }

  //Google signIn web
  Future<void> googleSignInWeb(BuildContext context) async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    await _auth.signInWithPopup(googleAuthProvider).onError(
        (error, stackTrace) => DialogBox(
            context, error.toString().replaceAll(RegExp('\\[.*?\\]'), '')));
    logger.d(
        "Current user is not empty = ${_auth.currentUser!.uid.isNotEmpty}"); // return T/F if user is empty or not
  }

  // Google signIn app
  Future<void> googleSignInMobile(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn()
        .signIn()
        .onError(
          (error, stackTrace) => DialogBox(
              context, error.toString().replaceAll(RegExp('\\[.*?\\]'), '')),
        );
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // connecting the firebase database with the google signIn
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await _auth.signInWithCredential(credential).then(
      (value) {
        logger.d("Google SignIn successful");
      },
    ).onError(
      (error, stackTrace) {
        logger.d("Google signIn error = $error");
        DialogBox(
            context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
      },
    );
  }

  //Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // DATABASE
  // ADD Expense
  Future addExpense(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textformfield(
                      text: "Name",
                      containerWidth: 120.0,
                      hintText: "Name",
                      controller: controllerName,
                      validator: (text) {
                        if (text.toString().isEmpty) {
                          return "Requried";
                        }
                      }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Textformfield(
                      keyboardInput: TextInputType.number,
                      text: "Amount",
                      containerWidth: 120.0,
                      hintText: "Amount",
                      controller: controllerAmount,
                      validator: (amount) {
                        if (amount.toString().isEmpty) {
                          return "Requried";
                        }
                      })
                ],
              )),
          actions: [
            Materialbutton(
                onpressFunction: () async {
                  if (formKey.currentState!.validate()) {
                    //give true if the input is correct
                    await userCollection
                        .doc(_auth.currentUser!.uid)
                        .collection("expenses")
                        .add({
                      "name": controllerName.text,
                      "amount": controllerAmount.text
                    }).onError(
                      (error, stackTrace) {
                        logger.d("add expense error:$error");
                        return DialogBox(context, error.toString());
                      },
                    );
                    Navigator.pop(context);
                  }
                },
                buttontext: "Save",
                textSize: 16.0)
          ],
        );
      },
    );
  }

  // ADD income
  Future addIncome(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textformfield(
                      text: "Name",
                      containerWidth: 120.0,
                      hintText: "Name",
                      controller: controllerName,
                      validator: (text) {
                        if (text.toString().isEmpty) {
                          return "Requried";
                        }
                      }),
                  SizedBox(
                    width: 10.0,
                  ),
                  Textformfield(
                      keyboardInput: TextInputType.number,
                      text: "Amount",
                      containerWidth: 120.0,
                      hintText: "Amount",
                      controller: controllerAmount,
                      validator: (amount) {
                        if (amount.toString().isEmpty) {
                          return "Requried";
                        }
                      })
                ],
              )),
          actions: [
            Materialbutton(
                onpressFunction: () async {
                  if (formKey.currentState!.validate()) {
                    await userCollection
                        .doc(_auth.currentUser!.uid)
                        .collection("income")
                        .add({
                      "name": controllerName.text,
                      "amount": controllerAmount.text
                    }).onError(
                      (error, stackTrace) {
                        logger.d("add income error : $error");
                        return DialogBox(context, error.toString());
                      },
                    );
                    Navigator.pop(context);
                  }
                },
                buttontext: "Save",
                textSize: 16.0)
          ],
        );
      },
    );
  }

  // getting the list of data for expenses when there is the change in the database using stream builders
  void expensesStream() async {
    await for (var snapshot in userCollection
        .doc(_auth.currentUser!.uid)
        .collection("expenses")
        .snapshots()) {
      // all the values are reloaded in stream so we use a empty list to store the previous values
      expenseAmount = [];
      expenseName = [];
      // To neglect the duplication of data as stream download the whole data
      for (var expense in snapshot.docs) {
        expenseName.add(expense.data()["name"]);
        expenseAmount.add(expense.data()["amount"]);
        notifyListeners();
      }
    }
  }

  // getting the list of data for expenses when there is the change in the database using stream builders
  void incomeStream() async {
    await for (var snapshot in userCollection
        .doc(_auth.currentUser!.uid)
        .collection("income")
        .snapshots()) {
      incomeAmount = [];
      incomeName = [];
      for (var income in snapshot.docs) {
        incomeName.add(income.data()["name"]);
        incomeAmount.add(income.data()["amount"]);
        notifyListeners();
      }
    }
  }

  // Reset button
  Future<void> reset() async {
    // for expense section
    await userCollection
        .doc(_auth.currentUser!.uid)
        .collection("expenses")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    // for income section
    await userCollection
        .doc(_auth.currentUser!.uid)
        .collection("income")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
