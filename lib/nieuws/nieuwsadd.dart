import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';
import 'package:intl/intl.dart';

class NieuwsAddPage extends StatelessWidget {
  TextEditingController _titel = new TextEditingController();
  TextEditingController _info = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeHeight = SizeConfig.blockSizeVertical;
    var sizeWidth = SizeConfig.blockSizeHorizontal;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yy').format(now);
    print(formattedDate);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Nieuws Toevoegen',
                    style: TextStyle(
                        fontSize: sizeHeight * 4, fontWeight: FontWeight.bold),
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
              height: sizeHeight * 3,
            ),
            Text(
              'Titel',
              style: TextStyle(fontSize: sizeHeight * 3),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: TextField(
                    decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    controller: _titel,
                  )),
            ),
            SizedBox(
              height: sizeHeight * 3,
            ),
            Text(
              'Info',
              style: TextStyle(fontSize: sizeHeight * 3),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: TextField(
                    decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    maxLines: 15,
                    controller: _info,
                  )),
            ),
            SizedBox(
              height: sizeHeight * 3,
            ),
            Container(
              width: sizeWidth * 100,
              height: sizeHeight * 10,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.blue,
                  child: Text(
                    'Bevestigen',
                    style: TextStyle(
                        fontSize: sizeHeight * 4, color: Colors.white),
                  ),
                  onPressed: () {
                    Firestore.instance.collection('Nieuws').add({
                      'Info': _info.text,
                      'Titel': _titel.text,
                      'Datum': formattedDate
                    });
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
