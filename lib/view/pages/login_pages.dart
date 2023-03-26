import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hlper/firebase_hlper.dart';

class Sing_In extends StatefulWidget {
  const Sing_In({super.key});

  @override
  State<Sing_In> createState() => _Sing_InState();
}

class _Sing_InState extends State<Sing_In> {
  TextEditingController Email = TextEditingController();
  TextEditingController PassWord = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? email;
  String? password;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    getper();
  }

  getper() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Widget EnterEmaile() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
          ),
        ],
      ),
      child: TextFormField(
        controller: Email,
        onSaved: (val) {
          setState(() {
            email = val;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Email...";
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.person),
          hintText: "Email",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.5,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget EnterPassword() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
          ),
        ],
      ),
      child: TextFormField(
        controller: PassWord,
        onSaved: (val) {
          setState(() {
            password = val;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Password...";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.lock),
          hintText: "Passoword",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 1.5,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/images/reg.gif",
                scale: 2.8,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                  height: -2,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Log in to your existant account of Q Aliure",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      EnterEmaile(),
                      SizedBox(
                        height: 20,
                      ),
                      EnterPassword(),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 170,
                  ),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff0148a4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Color(0xff0148a4),
                    ),
                  ),
                  onPressed: () async {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      Map<String, dynamic> k = await Firbase_Hlper.fireHleper
                          .sign_In(email: email!, password: password!);

                      if (k['user'] != null) {
                        await sharedPreferences.setBool("isLogin", true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sing In SuccFully...."),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.of(context).pushReplacementNamed("Home");
                        print("Parth");
                      } else if (k['error'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${k['error']}"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sing In Faill...."),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      setState(() {
                        email = "";
                        password = "";

                        Email.clear();
                        PassWord.clear();
                      });
                    } else {}
                  },
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Or connect using",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Color(0xff385c8e),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.facebook_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Facebook",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Map<String, dynamic> k =
                          await Firbase_Hlper.fireHleper.google_with_login();
                      if (k['user'] != null) {
                        await sharedPreferences.setBool("isLogin", true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sing In SuccFully...."),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.of(context).pushReplacementNamed("Home");
                        print("Parth");
                      } else if (k['error'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${k['error']}"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sing In Faill...."),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Color(0xfff14436),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 9,
                            ),
                            Container(
                              height: 20,
                              child: Image.asset("assets/images/googles.png"),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed("SingUp");
                    },
                    child: Text(
                      "Singn Up",
                      style: TextStyle(
                        color: Color(0xff207ffe),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
