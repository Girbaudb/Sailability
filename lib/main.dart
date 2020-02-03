import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sailability_app/Inlog/inlog.dart';
import 'package:sailability_app/home.dart';
import 'Inlog/register.dart';
import 'MediaQ/sizeConfig.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.loggedIn, this.widgetLogin}) : super(key: key);

  final String title;
  final loggedIn;
  Widget widgetLogin;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var login = false;
  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {
                  setState(() {
                    login = true;
                    widget.widgetLogin = RegisterPage();
                  })
                }
              else
                {
                  Firestore.instance
                      .collection("Users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home())))
                      .catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeWidth = SizeConfig.blockSizeHorizontal;
    var sizeHeight = SizeConfig.blockSizeVertical;

    
    if (login == false) {
      return Container();
    } else {
      return widget.widgetLogin;
    }
  }
}

class Loading extends StatelessWidget {
  const Loading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Center(
          child: Container(
        child: Text('Loading..'),
      ))),
    );
  }
}
