import 'package:author_app/hlper/firebase_hlper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Login_Up extends StatefulWidget {
  const Login_Up({super.key});

  @override
  State<Login_Up> createState() => _Login_UpState();
}

class _Login_UpState extends State<Login_Up> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController passoword = TextEditingController();
  TextEditingController conrifipassoword = TextEditingController();

  String? User;
  String? Email;
  int? Phone;
  String? Passoword;
  String? ConfiPassoword;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Widget Enteruser() {
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
        controller: username,
        onSaved: (val) {
          setState(() {
            User = val;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter UserName...";
          }
          return null;
        },
        // keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.person),
          hintText: "UserName",
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
        controller: email,
        onSaved: (val) {
          setState(() {
            Email = val;
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
          prefixIcon: Icon(CupertinoIcons.mail),
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

  Widget EnterPhone() {
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
        controller: phone,
        onSaved: (val) {
          setState(() {
            Phone = int.parse(val!);
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Phone...";
          } else if (value!.length < 10) {
            return "Legth geterthen 10...";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.device_phone_portrait),
          hintText: "Phone",
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
        controller: passoword,
        onSaved: (val) {
          setState(() {
            Passoword = val;
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

  Widget EnterCongPassword() {
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
        controller: conrifipassoword,
        onSaved: (val) {
          setState(() {
            ConfiPassoword = val;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter ConfiPassword...";
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.lock),
          hintText: "Confirm Passoword",
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
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Let's Get Started!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Create an account to Q Allure to get all features",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              Form(
                key: _globalKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Enteruser(),
                      SizedBox(
                        height: 10,
                      ),
                      EnterEmaile(),
                      SizedBox(
                        height: 10,
                      ),
                      EnterPhone(),
                      SizedBox(
                        height: 10,
                      ),
                      EnterPassword(),
                      SizedBox(
                        height: 10,
                      ),
                      EnterCongPassword(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 60,
                width: 200,
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
                      if (Passoword == ConfiPassoword) {
                        Map<String, dynamic> k = await Firbase_Hlper.fireHleper
                            .sign_up(email: Email!, password: Passoword!);
                        if (k['user'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Sing Up SuccFully...."),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ),
                          );
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
                              content: Text("Sing Up Faill...."),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
        
                        setState(() {
                          ConfiPassoword = "";
                          Passoword = "";
                          User = "";
                          Email = "";
                          Phone = null;
        
                          username.clear();
                          email.clear();
                          phone.clear();
                          passoword.clear();
                          conrifipassoword.clear();
                        });
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Password And ConfirmPaswwod Not Match..."),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {}
                  },
                  child: Text(
                    "CREATE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login here",
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
