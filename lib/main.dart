import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trace_app_3b/screens/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(TraceApp());
}

//!!! TRACE APP
//! 1) Register both a) client and b) establishment - Firebase Auth
//DONE 2) Login - Firebase Auth
// 3) QR Code generation -qr package
// 4) Scan QR Code-qr
// 5) Log/trace-Firebase Firestore

class TraceApp extends StatelessWidget {
  const TraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}
