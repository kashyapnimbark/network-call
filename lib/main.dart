import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:joistic_job_portal/routes/routs.dart';

import 'module/company Listing/presentation/pages/companyListingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Routes.routs,
      initialRoute: Routes.companyListingScreen,
    );
  }

  Future<void> _googleSignInMethod() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // If the user grants access, obtain an authentication token.
      if (googleAuth != null) {
        print("googleAuth");

        print(googleAuth.accessToken);
        print(googleAuth.idToken);
      } else {
        print("Else");
      }
    } catch (error) {
      print("error");

      print(error);
    }
  }
}
