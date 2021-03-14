import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refer_demo/home_page.dart';
import 'package:refer_demo/refer_service.dart';
import 'package:share/share.dart';

class ReferPage extends StatelessWidget {
  final uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(uid),
            ElevatedButton(
              onPressed: () async {
                Uri referLink = await DynamicLinkService.createDynamicLink(uid);
                Share.share(referLink.toString());
              },
              child: Text("Share Refer Code"),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => HomePage(),
                    ),
                    (route) => false);
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
