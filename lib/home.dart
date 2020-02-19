import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/main.dart';

import 'MediaQ/sizeConfig.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;
  int _currentIndex = 0;
  List<Widget> _tabList = [];

  @override
  void initState() {
    super.initState();

    _tabList = [
      Center(
        child: Center(
            child: MaterialButton(
          color: Colors.black,
          onPressed: () {
            FirebaseAuth.instance.signOut();
            //print('$user');
            runApp(new MaterialApp(
              home: new MyHomePage(),
            ));
          },
        )),
      ),
      Center(
        child: Text('ddadzda'),
      ), //center
      Center(
        child: Text('dd'),
      ),
      Center(
        child: Text('dzd'),
      ),
      Center(
        child: Text('enne'),
      ),
    ];

    tabController = TabController(length: _tabList.length, vsync: this);
    tabController.index = 2;
    tabController.addListener(() {
      setState(() {
        _currentIndex = tabController.index;
        tabController.animateTo(_currentIndex);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(controller: tabController, children: _tabList),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
            tabController.animateTo(_currentIndex);
            print(_tabList[_currentIndex]);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.headset),
            title: new Text('Mood'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.event_available),
            title: new Text('Aanwezigheid'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profiel'))
        ],
      ),
    );
  }
}
