import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:refer_demo/refer_page.dart';
import 'package:refer_demo/refer_service.dart';

class HomePage extends StatefulWidget {
  final String referCode;

  HomePage({Key key, this.referCode}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  final _referCodeTextController = TextEditingController();

  onResumeHandleDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      _handleDynamicLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  initDynamicLinks(BuildContext context) async {
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    print(data);
    _handleDynamicLink(data);
  }

  _handleDynamicLink(PendingDynamicLinkData data) {
    var deepLink = data?.link;
    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if (queryParams.length > 0) {
        var referCode = queryParams['refer_code'];
        print("Refer Code is" + referCode);
        _referCodeTextController.clear();
        _referCodeTextController.text = referCode;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    this.initDynamicLinks(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('App Resumed');
      this.onResumeHandleDynamicLink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _referCodeTextController,
              decoration: InputDecoration(
                filled: true,
                labelText: "Refer Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInAnonymously();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ReferPage(),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
