import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:sailability_app/Inlog/register.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';

class WhoRU extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WhoRUState();
  }
}

class _WhoRUState extends State<WhoRU> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeWidth = SizeConfig.blockSizeHorizontal;
    var sizeHeight = SizeConfig.blockSizeVertical;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(20, sizeHeight * 30, 20, sizeHeight * 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                width: sizeWidth * 100,
                height: sizeHeight * 15,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                    child: Text('Zeiler', style: TextStyle(color: Colors.white, fontSize: sizeHeight*3),),
                  onPressed: () {},
                  color: Colors.blue,
                )),
            Container(
                width: sizeWidth * 100,
                height: sizeHeight * 15,
                child: RaisedButton(
                    child: Text('Begeleider', style: TextStyle(color: Colors.white, fontSize: sizeHeight*3),),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    })),
          ],
        ),
      ),
    );
  }
}
