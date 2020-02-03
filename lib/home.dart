import 'package:flutter/material.dart';

import 'MediaQ/sizeConfig.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
 
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // this will be set when a new tab is tapped
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
