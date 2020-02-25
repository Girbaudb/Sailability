import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/Aanwezigheden/tijdstip.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';
import 'package:sailability_app/nieuws/nieuwsadd.dart';
import 'package:sailability_app/nieuws/nieuwsinfo.dart';

class MoodPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MoodPageState();
  }
}

class _MoodPageState extends State<MoodPage> {
  var userId;
  var username;
  bool zeiler;
  bool sel1 = false;
  bool sel2 = false;
  bool sel3 = false;
  bool sel4 = false;
  bool sel5 = false;
  bool sel6 = false;

  bool selu1 = false;
  bool selu2 = false;
  bool selu3 = false;

  bool actiefZeilen = false;
  bool praten = false;
  bool instructief = false;
  var duur;
  TextEditingController opmerking = new TextEditingController();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((f) {
      Firestore.instance.collection('Users').document(f.uid).get().then((v) {
        setState(() {
          username = f.uid;
          zeiler = v.data['Zeiler'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeHeight = SizeConfig.blockSizeVertical;
    var sizeWidth = SizeConfig.blockSizeHorizontal;
    print(userId);

    return Scaffold(
      body: Container(
        height: sizeHeight * 100,
        width: sizeWidth * 100,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Gemoedstoestand',
                        style: TextStyle(
                            fontSize: sizeHeight * 4,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: sizeHeight * 5),
                  Text(
                    'Actief zeilen?',
                    style: TextStyle(fontSize: sizeHeight * 3),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ToggleButtons(
                        borderRadius: BorderRadius.circular(200),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Text('Ja'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Text('Nee'),
                          )
                        ],
                        onPressed: (f) {
                          if (f == 1) {
                            setState(() {
                              sel2 = true;
                              sel1 = false;
                            });
                          } else {
                            setState(() {
                              sel2 = false;
                              sel1 = true;
                            });
                          }
                        },
                        selectedColor: Colors.blue,
                        isSelected: [sel1, sel2]),
                  ),
                  Text(
                    'Praatje slaan?',
                    style: TextStyle(fontSize: sizeHeight * 3),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ToggleButtons(
                        borderRadius: BorderRadius.circular(200),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Text('Ja'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Text('Nee'),
                          )
                        ],
                        onPressed: (f) {
                          if (f == 1) {
                            setState(() {
                              sel4 = true;
                              sel3 = false;
                            });
                          } else {
                            setState(() {
                              sel4 = false;
                              sel3 = true;
                            });
                          }
                        },
                        selectedColor: Colors.blue,
                        isSelected: [sel3, sel4]),
                  ),
                  Text(
                    'Instructief?',
                    style: TextStyle(fontSize: sizeHeight * 3),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ToggleButtons(
                        borderRadius: BorderRadius.circular(200),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Text('Ja'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Text('Nee'),
                          )
                        ],
                        onPressed: (f) {
                          if (f == 1) {
                            setState(() {
                              sel6 = true;
                              sel5 = false;
                            });
                          } else {
                            setState(() {
                              sel6 = false;
                              sel5 = true;
                            });
                          }
                        },
                        selectedColor: Colors.blue,
                        isSelected: [sel5, sel6]),
                  ),
                  Text(
                    'Duur?',
                    style: TextStyle(fontSize: sizeHeight * 3),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ToggleButtons(
                        borderRadius: BorderRadius.circular(200),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Text('1 uur'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Text('2 uur'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Text('3 uur'),
                          )
                        ],
                        onPressed: (f) {
                          setState(() {
                            duur = f;

                            if (f == 0) {
                              selu1 = true;
                              selu2 = false;
                              selu3 = false;
                            }
                            if (f == 1) {
                              selu1 = false;
                              selu2 = true;
                              selu3 = false;
                            }
                            if (f == 2) {
                              selu1 = false;
                              selu2 = false;
                              selu3 = true;
                            }
                          });
                        },
                        selectedColor: Colors.blue,
                        isSelected: [selu1, selu2, selu3]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
