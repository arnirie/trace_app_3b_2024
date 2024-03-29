import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:trace_app_3b/screens/client.dart';
import 'package:trace_app_3b/screens/home.dart';
import 'package:trace_app_3b/screens/register_client.dart';
import 'package:trace_app_3b/screens/register_establishment.dart';
import 'firebase_options.dart';
import 'package:trace_app_3b/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(TraceApp());
}

//TRACING APP
//!1) Register both a) client and b) establishment - Firebase Auth
//!2) Login a) client and b) establishment - Auth
//!3) QR Code generation - qr package
//!4) Scan QR Code - qr package
//5) Log/Trace - Firebase Firestore

class TraceApp extends StatelessWidget {
  const TraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //circular progress indicator
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasData) {
            //user is currently signed in
            String userId = snapshot.data!.uid;
            return ClientScreen(userId: userId);
          }
          return HomeScreen();
        },
      ),
      builder: EasyLoading.init(),
      theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: TextTheme(
            displaySmall: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w100,
            ),
          )),
    );
  }
}
