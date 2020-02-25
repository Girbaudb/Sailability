import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';
import 'package:sailability_app/nieuws/nieuwsadd.dart';
import 'package:sailability_app/nieuws/nieuwsinfo.dart';

class NieuwsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NieuwsPageState();
  }
}

class _NieuwsPageState extends State<NieuwsPage> {
  var userId;

  @override
  void initState() {
    super.initState();
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
            stream: Firestore.instance.collection('Nieuws').snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) return Container();
                if (!snapshot.hasData) return Container();
              return Column(
                children: <Widget>[
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Nieuws',
                          style: TextStyle(
                              fontSize: sizeHeight * 5,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        NieuwsAddPage()));
                          },
                          child: Icon(
                            Icons.add,
                            size: sizeHeight * 4,
                          ),
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

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: new ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      NieuwsInfoPage(
                                    document: _card,
                                  ),
                                ),
                              );
                            },
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    _card['Titel'],
                                    style: TextStyle(fontSize: sizeHeight * 2),
                                  ),
                                  Text(
                                    _card['Datum'],
                                    style: TextStyle(
                                        fontSize: sizeHeight * 1.5,
                                        color: Colors.black45),
                                  ),
                                ]),
                          ),
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
