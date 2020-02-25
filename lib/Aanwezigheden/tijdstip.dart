import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';
import 'package:sailability_app/main.dart';
import 'package:sailability_app/nieuws/nieuwsadd.dart';
import 'package:sailability_app/nieuws/nieuwsinfo.dart';

class TijdStipPage extends StatefulWidget {
  TijdStipPage({@required this.boot});
  final boot;

  @override
  State<StatefulWidget> createState() {
    return _TijdStipPageState(boot: boot);
  }
}

class _TijdStipPageState extends State<TijdStipPage> {
  _TijdStipPageState({@required this.boot});
  final boot;
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
          child: StreamBuilder(
            stream: Firestore.instance.collection('Aanwezigheden').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Column(
                children: <Widget>[
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Tijdstip',
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
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DocumentSnapshot _card =
                            snapshot.data.documents[index];

                        return Container(
                          width: sizeWidth * 100,
                          height: sizeHeight * 1000,
                          child: new ListView.builder(
                              itemCount: _card['Planning'].length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Column(children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: new ListTile(
                                        onTap: () async {
                                          await Firestore.instance
                                              .collection('Users')
                                              .document(username)
                                              .get()
                                              .then((f) {
                                            setState(() {
                                              userId = f.data['Naam'];
                                            });
                                          });

                                          Map map = _card['Planning'];

                                          if (map[_card['Planning']
                                                  .keys
                                                  .elementAt(index)] ==
                                              userId) {
                                            Map map = _card['Planning'];
                                            map[_card['Planning']
                                                .keys
                                                .elementAt(index)] = '';
                                          } else {
                                            map[_card['Planning']
                                                    .keys
                                                    .elementAt(index)] =
                                                [userId,boot];
                                          }

                                          Firestore.instance
                                              .collection('Aanwezigheden')
                                              .document(_card.documentID)
                                              .updateData({'Planning': map});

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyHomePage()));
                                        },
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Text(_card['Planning']
                                                .keys
                                                .elementAt(index)),
                                            new Text(_card['Planning']
                                                [_card['Planning']
                                                .keys
                                                .elementAt(index)][0]),
                                          ],
                                        )),
                                  ),
                                ]);
                              }),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
