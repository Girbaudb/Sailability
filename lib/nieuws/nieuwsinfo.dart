import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';

class NieuwsInfoPage extends StatelessWidget {
  NieuwsInfoPage({@required this.document});
  final document;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeHeight = SizeConfig.blockSizeVertical;
    var sizeWidth = SizeConfig.blockSizeHorizontal;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: sizeWidth * 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          document['Titel'],
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: sizeHeight * 5,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          document['Datum'],
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: sizeHeight * 2,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: sizeHeight * 4,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: sizeHeight * 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,20,10,20),
                child: Text(
                  document['Info'],
                  style: TextStyle(fontSize: sizeHeight * 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
