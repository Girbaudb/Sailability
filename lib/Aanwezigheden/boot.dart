import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/Aanwezigheden/tijdstip.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';
import 'package:sailability_app/nieuws/nieuwsadd.dart';
import 'package:sailability_app/nieuws/nieuwsinfo.dart';

class BootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BootPageState();
  }
}

class _BootPageState extends State<BootPage> {
  var userId;
  var username;
  bool zeiler;

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Boot',
                              style: TextStyle(
                                  fontSize: sizeHeight * 4,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              child: Icon(Icons.arrow_back),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 200, 0, 200),
                          height: sizeHeight * 80,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: sizeHeight * 7,
                                  width: sizeWidth * 90,
                                  child: RaisedButton(
                                    child: Text(
                                      'Hanza',
                                      style:
                                          TextStyle(fontSize: sizeHeight * 2),
                                    ),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    splashColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TijdStipPage(boot: 'Hanza',)));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: sizeHeight * 7,
                                  width: sizeWidth * 90,
                                  child: RaisedButton(
                                    child: Text(
                                      'Trimaran',
                                      style:
                                          TextStyle(fontSize: sizeHeight * 2),
                                    ),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    splashColor: Colors.white,
                                    onPressed: () {
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TijdStipPage(boot: 'Trimaran',)));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: sizeHeight * 7,
                                  width: sizeWidth * 90,
                                  child: RaisedButton(
                                    child: Text(
                                      'F6',
                                      style:
                                          TextStyle(fontSize: sizeHeight * 2),
                                    ),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    splashColor: Colors.white,
                                    onPressed: () {
                                       Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TijdStipPage(boot: 'F6',)));
                                    },
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                ])));
  }
}
