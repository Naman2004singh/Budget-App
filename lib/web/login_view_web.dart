import 'package:budget_app/components/materialButton.dart';
import 'package:budget_app/components/textFields.dart';
import 'package:budget_app/components/textTheme.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginViewWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailController = useTextEditingController();
    TextEditingController _passwordController = useTextEditingController();
    final viewModelProvider = ref.watch(viewModel);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/login_image.png",
            width: deviceWidth / 2.6,
          ),
          SingleChildScrollView(
            child: Column(
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
                  height: 40.0,
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
                    SizedBox(
                        height: 50.0,
                        width: 150.0,
                        child: Materialbutton(
                            onpressFunction: () async {
                              await viewModelProvider.RegisterUser(
                                  context,
                                  _emailController.text,
                                  _passwordController.text);
                            },
                            buttontext: "Register",
                            textSize: 25)),
                    SizedBox(
                      width: 20.0,
                    ),
                    Pacifico(text: "OR", size: 15.0),
                    SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      height: 50.0,
                      width: 150.0,
                      child: Materialbutton(
                          onpressFunction: () async {
                            await viewModelProvider.LoginUser(
                                context,
                                _emailController.text,
                                _passwordController.text);
                          },
                          buttontext: "Login",
                          textSize: 25),
                    ),
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
          )
        ],
      ),
    ));
  }
}
