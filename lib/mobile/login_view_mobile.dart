import 'package:budget_app/components/textFields.dart';
import 'package:budget_app/components/textTheme.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: MaterialButton(
                    onPressed: () async {
                      await viewModelProvider.RegisterUser(context,
                          _emailController.text, _passwordController.text);
                    },
                    splashColor: Colors.grey,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: OpenSans(
                      text: "Register",
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
