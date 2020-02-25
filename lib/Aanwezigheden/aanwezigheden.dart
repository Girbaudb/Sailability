import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/Aanwezigheden/boot.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AanwezigheidsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AanwezigheidsPageState();
  }
}

class _AanwezigheidsPageState extends State<AanwezigheidsPage> {
  var userId;
  var username;
  bool zeiler = false;
  PanelController slidingController = new PanelController();
  var document;
  var person;
  var time;
  var img;
  var boot;

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

    if (zeiler) {
      return Scaffold(
        body: Container(
            height: sizeHeight * 100,
            width: sizeWidth * 100,
            padding: EdgeInsets.all(20),
            child: StreamBuilder(
              stream:
                  Firestore.instance.collection('Aanwezigheden').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) return Container();
                if (!snapshot.hasData) return Container();
                if (snapshot.hasData && snapshot.data != null) {
                  return Column(
                    children: <Widget>[
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Aanwezigheid',
                              style: TextStyle(
                                  fontSize: sizeHeight * 4,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot _card =
                                snapshot.data.documents[index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            BootPage()));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Zondag',
                                          style: TextStyle(
                                              fontSize: sizeHeight * 2.5)),
                                      Text(
                                        _card['Datum'],
                                        style: TextStyle(
                                            fontSize: sizeHeight * 2.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            )),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            StreamBuilder(
              stream:
                  Firestore.instance.collection('Aanwezigheden').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) return Container();
                if (!snapshot.hasData) return Container();
                if (snapshot.hasData && snapshot.data != null) {
                  return Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Aanwezigheden',
                                style: TextStyle(
                                    fontSize: sizeHeight * 4,
                                    fontWeight: FontWeight.bold),
                              ),
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var timeDing = _card['Planning']
                                                      .keys
                                                      .elementAt(index).toString();

                                         
                                      return new Column(children: <Widget>[
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: new ListTile(
                                              onTap: () async {
                                                setState(() {
                                                  document = _card;
                                                  time = _card['Planning']
                                                      .keys
                                                      .elementAt(index);

                                                  person = _card['Planning'][timeDing][0].toString();
                                                  boot = _card['Planning'][timeDing][1].toString();

                                                  time = _card['Planning']
                                                      .keys
                                                      .elementAt(index);
                                                });

                                                await Firestore.instance
                                                    .collection('Users')
                                                    .getDocuments()
                                                    .then((f) {
                                                  f.documents.forEach((v) {
                                                    if (v.data['Naam'] ==
                                                        person) {
                                                      setState(() {
                                                        img = v.data['Img'];
                                                      });
                                                    }
                                                  });
                                                });
                                                print(document);
                                                slidingController.open();
                                              },
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  new Text(timeDing),
                                                  new Text(_card['Planning'][timeDing][0].toString())
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
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SlidingUpPanel(
              renderPanelSheet: false,
              maxHeight: sizeHeight * 50,
              minHeight: 0,
              controller: slidingController,
              backdropEnabled: true,
              backdropTapClosesPanel: true,
              panel: Container(
                  height: sizeHeight * 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20.0,
                          color: Colors.grey,
                        ),
                      ]),
                  margin: const EdgeInsets.all(24.0),
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Aanwezig',
                            style: TextStyle(
                                fontSize: sizeHeight * 5,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: sizeHeight * 2),
                          CircleAvatar(
                            backgroundImage: NetworkImage(img.toString()),
                            radius: sizeHeight * 7,
                          ),
                          SizedBox(height: sizeHeight * 3),
                          Text(
                            person.toString(),
                            style: TextStyle(
                              fontSize: sizeHeight * 3,
                            ),
                          ),
                          Text(
                            boot.toString(),
                            style: TextStyle(
                              fontSize: sizeHeight * 2.5,
                            ),
                          ),
                          SizedBox(height: sizeHeight * 1),
                          Text(time.toString(),style: TextStyle(
                              fontSize: sizeHeight * 2,
                              color: Colors.black45
                            ),),
                        ]),
                  )),
            ),
          ],
        ),
      );
    }
  }
}
