import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';

class Inlog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InlogState();
  }
}

class _InlogState extends State<Inlog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Center(),
    );
  }
}
