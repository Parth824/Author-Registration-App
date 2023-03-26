import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../hlper/dbhlper.dart';
import '../../hlper/firebase_hlper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController namecontoroll = TextEditingController();
  TextEditingController bookcontoroll = TextEditingController();

  TextEditingController nameup = TextEditingController();
  TextEditingController bookup = TextEditingController();

  String? book;
  String? Authorname;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    getper();
  }

  getper() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firbase App"),
        actions: [
          InkWell(
            onTap: () async{
              Firbase_Hlper.fireHleper.Logout();
              await sharedPreferences.setBool("isLogin", false);
              Navigator.pushReplacementNamed(context, 'Login');
            },
            child: Icon(
              Icons.power_settings_new,
              size: 30,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          InsertRecode();
        },
        label: Text("Insert"),
        icon: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: Dbhlper.db.collection('books').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Not Data Found...."),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? dataall = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> datas =
                dataall!.docs;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, i) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      isThreeLine: true,
                      leading: Text(
                        "${i + 1}",
                      ),
                      title: Text(
                        "${datas[i]['name']}",
                      ),
                      subtitle: Text(
                        "${datas[i]['book']}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Update(k: datas[i].data(), id: datas[i].id);
                            },
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Dbhlper.dbhlper.Delete(id: datas[i].id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "DELEDT Data Succffuly",
                                  ),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    
    );
  }

  Update({required Map<String, dynamic> k, required String id}) {
    nameup.text = k['name'];
    bookup.text = k['book'];

    book = k['book'];
    Authorname = k['name'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Recode"),
        content: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameup,
                  onSaved: (val) {
                    setState(() {
                      Authorname = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The AthoerName..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter AuthoerName",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bookup,
                  onSaved: (val) {
                    setState(() {
                      book = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The BookName..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Book name",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () async {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();

                Map<String, dynamic> data = {
                  "name": Authorname,
                  "book": book,
                };
                print(data);
                print(id);
                Dbhlper.dbhlper.update(id: id, k: data);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Updata Data Succffuly",
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              setState(() {
                nameup.clear();
                bookup.clear();

                Authorname = "";
                book = "";
              });
            },
            child: Text("UPDATA"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                nameup.clear();
                bookup.clear();

                Authorname = "";
                book = "";
              });
            },
            child: Text("Clear"),
          ),
        ],
      ),
    );
  }

  InsertRecode() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Insert Recode"),
        content: Form(
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namecontoroll,
                  onSaved: (val) {
                    setState(() {
                      Authorname = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The AuthoerName..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter AuthoerName",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: bookcontoroll,
                  onSaved: (val) {
                    setState(() {
                      book = val;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter The BookName..";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Books name",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              if (_globalKey.currentState!.validate()) {
                _globalKey.currentState!.save();

                Map<String, dynamic> data = {
                  "name": Authorname,
                  "book": book,
                };
                Dbhlper.dbhlper.insert(data: data);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Inser Data Succffuly",
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              setState(() {
                namecontoroll.clear();
                bookcontoroll.clear();

                Authorname = "";
                book = "";
              });
            },
            child: Text("Add"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                namecontoroll.clear();
                bookcontoroll.clear();

                Authorname = "";
                book = "";
              });
            },
            child: Text("Clear"),
          ),
        ],
      ),
    );
  }
}
