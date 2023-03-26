import 'package:author_app/view/pages/home_page.dart';
import 'package:author_app/view/pages/login_pages.dart';
import 'package:author_app/view/pages/restion_page.dart';
import 'package:author_app/view/pages/sples_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/":(context) => spl_scn(),
        "Login":(context) => Sing_In(),
        "SingUp":(context) => Login_Up(),
        "Home":(context) => HomePage(),
      },
    ),
  );
}
