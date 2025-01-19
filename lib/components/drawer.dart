import 'package:budget_app/components/materialButton.dart';
import 'package:budget_app/view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerHeader(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black)),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 180.0,
                  // backgroundImage: AssetImage("assets/logo.png"),
                  child: Image(
                    image: AssetImage("assets/logo.png"),
                    height: 100.0,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              )),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: 150.0,
            height: 50.0,
            child: Materialbutton(
                onpressFunction: () async {
                  await viewModelProvider.logout();
                },
                buttontext: "Logout",
                textSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(
                        "https://www.instagram.com/its_namansingh29/"));
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.instagram,
                    size: 35.0,
                  )),
              IconButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse("https://x.com/Naman2singh9/"));
                  },
                  icon: FaIcon(FontAwesomeIcons.twitter))
            ],
          )
        ],
      ),
    );
  }
}
