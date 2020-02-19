import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';
import 'package:sailability_app/groupselector/groupselector.dart';

class LedenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LedenPageState();
  }
}

class _LedenPageState extends State<LedenPage> {
  var userId;
  var stream = Firestore.instance.collection('Users').snapshots();
  var streamZeil = Firestore.instance
      .collection('Users')
      .where('Zeiler', isEqualTo: true)
      .snapshots();
  var streamBeg = Firestore.instance
      .collection('Users')
      .where('Zeiler', isEqualTo: false)
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeHeight = SizeConfig.blockSizeVertical;
    var sizeWidth = SizeConfig.blockSizeHorizontal;

    return Scaffold(
        body: Container(
      height: sizeHeight * 100,
      width: sizeWidth * 100,
      child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GroupSelector(
                            selected: (selected) {
                              print(selected);

                              if (selected[0] == "Zeilers") {
                                setState(() {
                                  stream = streamZeil;
                                });
                              } else {
                                setState(() {
                                  stream = streamBeg;
                                });
                              }

                              if (selected.length > 1) {
                                stream = Firestore.instance
                                    .collection('Users')
                                    .snapshots();
                              }
                            },
                          ),
                        ]),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final DocumentSnapshot _card =
                            snapshot.data.documents[index];

                        return new ListTile(
                          title: Row(children: <Widget>[
                            new CircleAvatar(
                              radius: sizeHeight * 5,
                              backgroundImage: NetworkImage(_card['Img']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(_card['Naam'],
                                  style: TextStyle(fontSize: sizeHeight * 3)),
                            ),
                          ]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    ));
  }
}
