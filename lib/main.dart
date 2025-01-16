import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setPathUrlStrategy();
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBkzlyII3Kj4tORTqS3YHohmLY65IWO9GE",
            authDomain: "budget-app-828e2.firebaseapp.com",
            projectId: "budget-app-828e2",
            storageBucket: "budget-app-828e2.firebasestorage.app",
            messagingSenderId: "409242060459",
            appId: "1:409242060459:web:f3ee1191fbf9d8445659ee",
            measurementId: "G-KXVNN0RFMV"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Budget App",
    );
  }
}
