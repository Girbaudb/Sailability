import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';

import '../home.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  TextEditingController infoController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    infoController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Het ingevoerde mail adres is niet geldig.';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Wachtwoord moet langer zijn dan 8 tekens.';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeHeight = SizeConfig.blockSizeVertical;
    var sizeWidth = SizeConfig.blockSizeHorizontal;
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return Scaffold(
      body: Container(
        width: sizeWidth * 100,
        height: sizeHeight * 100,
        padding: const EdgeInsets.fromLTRB(20.0, 40, 20, 20),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                Text(
                  'Profiel Aanmaken',
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: sizeHeight * 4, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.rawlinsdavy.com/wp-content/uploads/2018/12/profile-placeholder-300x300.png'),
                  radius: sizeHeight * 5,
                ),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                Text(
                  'Wat is je naam?',
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: sizeHeight * 2.5),
                ),
                MediaQuery(
                  data: mqDataNew,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    elevation: 5,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "John Doe",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                      controller: firstNameInputController,
                      validator: (value) {
                        if (value.length < 3) {
                          return "Geef een correcte naam op.";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                MediaQuery(
                  data: mqDataNew,
                  child: Text(
                    'Wat is je email?',
                    textScaleFactor: 1,
                    style: TextStyle(fontSize: sizeHeight * 2.5),
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                MediaQuery(
                  data: mqDataNew,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "john.doe@gmail.com",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                      controller: emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                Text(
                  'Geef een wachtwoord',
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: sizeHeight * 2.5),
                ),
                MediaQuery(
                  data: mqDataNew,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "********",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                      controller: pwdInputController,
                      obscureText: true,
                      validator: pwdValidator,
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                Text(
                  'Extra Informatie',
                  textScaleFactor: 1,
                  style: TextStyle(fontSize: sizeHeight * 2.5),
                ),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                MediaQuery(
                  data: mqDataNew,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Info...",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                      controller: infoController,
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                Container(
                  width: sizeWidth * 100,
                  alignment: Alignment.bottomCenter,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: sizeWidth * 100,
                      height: sizeHeight * 10,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        elevation: 5,
                        child: Text("Bevestigen", style: TextStyle(fontSize: sizeHeight*3),),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_registerFormKey.currentState.validate()) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailInputController.text,
                                    password: pwdInputController.text)
                                .then((currentUser) => Firestore.instance
                                    .collection("Users")
                                    .document(currentUser.user.uid)
                                    .setData({
                                      "uid": currentUser.user.uid,
                                      "Naam": firstNameInputController.text,
                                      "Email": emailInputController.text,
                                      "Wachtwoord": pwdInputController.text,
                                      "Info": infoController.text,
                                      "Zeiler": false,
                                    })
                                    .then((result) => {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home()),
                                              (_) => false),
                                          firstNameInputController.clear(),
                                          lastNameInputController.clear(),
                                          emailInputController.clear(),
                                          pwdInputController.clear(),
                                          confirmPwdInputController.clear()
                                        })
                                    .catchError((err) => print(err)))
                                .catchError((err) => print(err));
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
