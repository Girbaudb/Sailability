import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';
import 'package:sailability_app/main.dart';
import 'package:sailability_app/mood.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  TabController tabController;
  int _currentIndex = 0;
  List<Widget> _tabList = [];
  var userId;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  getUser() async {
    await FirebaseAuth.instance.currentUser().then((onValue) {
      setState(() {
        userId = onValue.uid;
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
      child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Users')
              .document(userId.toString())
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else {
              var info = snapshot.data['Info'];
              var naam = snapshot.data['Naam'];
              var zeiler = snapshot.data['Zeiler'];
              var leeftijd = snapshot.data['Age'];
              var img = snapshot.data['Img'];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Profiel',
                            style: TextStyle(
                                fontSize: sizeHeight * 5,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.edit,
                            size: sizeHeight * 4,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: sizeHeight * 5,
                            ),
                            Text(
                              'Naam',
                              style: TextStyle(
                                  fontSize: sizeHeight * 3, color: Colors.blue),
                            ),
                            SizedBox(
                              height: sizeHeight * 1,
                            ),
                            Text(
                              naam,
                              style: TextStyle(fontSize: sizeHeight * 2),
                            ),
                            SizedBox(
                              height: sizeHeight * 5,
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: sizeHeight * 7,
                          backgroundImage: NetworkImage(img),
                        )
                      ],
                    ),
                    Text(
                      'Leeftijd',
                      style: TextStyle(
                          fontSize: sizeHeight * 3, color: Colors.blue),
                    ),
                    SizedBox(
                      height: sizeHeight * 1,
                    ),
                    Text(
                      leeftijd == null ? 'Geen leeftijd ingegeven' : leeftijd,
                      style: TextStyle(fontSize: sizeHeight * 2),
                    ),
                    SizedBox(
                      height: sizeHeight * 5,
                    ),
                    Text(
                      'Extra Informatie',
                      style: TextStyle(
                          fontSize: sizeHeight * 3, color: Colors.blue),
                    ),
                    SizedBox(
                      height: sizeHeight * 1,
                    ),
                    Text(
                      info,
                      style: TextStyle(fontSize: sizeHeight * 2),
                    ),
                    FloatingActionButton(onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    }),
                    FloatingActionButton(
                      child: Icon(Icons.feedback),
                      heroTag: 'rlf,oa,fzq',
                      onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoodPage()));
                    })
                  ],
                ),
              );
            }
          }),
    ));
  }
}
