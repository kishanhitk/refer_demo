import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:refer_demo/home_page.dart';

class DynamicLinkService {
  static Future<Uri> createDynamicLink(String uid) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://prachar5c6b7.page.link',
      link: Uri.parse('https://prachar-5c6b7.web.app/?id=$uid'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.refer_demo',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.example.refer_demo',
        minimumVersion: '1',
        appStoreId: 'com.example.refer_demo',
      ),
    );
    var dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl;
  }

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;
      if (deepLink != null) {
        print(deepLink.toString());
        // if (deepLink.queryParameters.containsKey('id')) {
        //   String id = deepLink.queryParameters['id'];
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => HomePage(
        //         referCode: id,
        //       ),
        //     ),
        //   );
        // }
      }

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(),
        //   ),
        // );
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
