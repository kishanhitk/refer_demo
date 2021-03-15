import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:refer_demo/error_page.dart';
import 'package:refer_demo/home_page.dart';
import 'package:refer_demo/refer_page.dart';

import 'loading_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return ErrorPage();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return FirebaseAuth.instance.currentUser != null
                ? ReferPage()
                : HomePage();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Loading();
        },
      ),
    );
  }
}
