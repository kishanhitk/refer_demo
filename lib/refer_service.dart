import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:refer_demo/home_page.dart';

class DynamicLinkService {
  static Future<Uri> createDynamicLink(String uid) async {
    print(uid);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://prachar5c6b7.page.link',
      link: Uri.parse('https://prachar-5c6b7.web.app/refer?refer_code=$uid'),
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
}
