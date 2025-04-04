import 'package:budget_app/components/materialButton.dart';
import 'package:budget_app/components/textFields.dart';
import 'package:budget_app/components/textTheme.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/sign_button.dart';

class LoginViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailController = useTextEditingController();
    TextEditingController _passwordController = useTextEditingController();
    final viewModelProvider = ref.watch(viewModel);
    final double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight / 5.5,
            ),
            Image.asset(
              "assets/logo.png",
              fit: BoxFit.contain,
              width: 210,
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 350.0,
              child: Textfields(
                  keyboardtype: TextInputType.emailAddress,
                  isObstacle: false,
                  textAlign: TextAlign.center,
                  editingController: _emailController,
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  hintText: "Email"),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 350.0,
              child: Textfields(
                  keyboardtype: TextInputType.text,
                  isObstacle: viewModelProvider.isObscure,
                  suffixIcon: IconButton(
                      onPressed: () => viewModelProvider.toggleObscure(),
                      icon: Icon(
                        viewModelProvider.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      )),
                  textAlign: TextAlign.center,
                  editingController: _passwordController,
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  hintText: "Password"),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Registration button
                Materialbutton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    onpressFunction: () async {
                      await viewModelProvider.RegisterUser(context,
                          _emailController.text, _passwordController.text);
                    },
                    buttontext: "Register",
                    textSize: 25.0),
                SizedBox(
                  width: 20.0,
                ),
                Pacifico(text: "OR", size: 15.0),
                SizedBox(
                  width: 20.0,
                ),
                Materialbutton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    onpressFunction: () async {
                      await viewModelProvider.LoginUser(context,
                          _emailController.text, _passwordController.text);
                    },
                    buttontext: "Login",
                    textSize: 25.0),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            SignInButton(
              buttonType: ButtonType.google,
              btnColor: Colors.black,
              btnTextColor: Colors.white,
              buttonSize: ButtonSize.medium,
              onPressed: () async {
                if (kIsWeb) {
                  viewModelProvider.googleSignInWeb(context);
                } else {
                  viewModelProvider.googleSignInMobile(context);
                }
              },
            )
          ],
        ),
      ),
    ));
  }
}
