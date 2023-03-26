import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'login_pages.dart';

class spl_scn extends StatefulWidget {
  const spl_scn({super.key});

  @override
  State<spl_scn> createState() => _spl_scnState();
}

class _spl_scnState extends State<spl_scn> {
  late SharedPreferences sharedPreferences;
  bool k = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getper();
    Future.delayed(
      Duration(
        seconds: 7,
      ),
      () {
        k = sharedPreferences.getBool("isLogin") ?? false;
        (k == false)
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Sing_In(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
      },
    );
  }

  getper() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              height: 250,
              child: Image.asset("assets/images/book.gif"),
            ),
            SizedBox(
              height: 150,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
