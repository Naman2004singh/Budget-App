import 'package:budget_app/components/textFields.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: deviceHeight,
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
              child: Textfields(keyboardtype: TextInputType.emailAddress,
              isObstacle: false,
               textAlign: TextAlign.center,
                editingController: _emailController,
                 prefixIcon: Icon(Icons.email, color: Colors.black,size: 30.0,),
                  hintText: "Email"),
            ),
            SizedBox(height: 20.0,),
            SizedBox(
              width: 350.0,
              child: Textfields(keyboardtype: TextInputType.text,
              // isObstacle: ,
               textAlign:TextAlign.center,
                editingController: _passwordController,
                 prefixIcon: Icon(Icons.password,color: Colors.black,size: 30.0,),
                  hintText: "Password"),
            )
          ],
        ),
      ),
    ));
  }
}
