import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sailability_app/MediaQ/sizeConfig.dart';

class GroupSelector extends StatefulWidget {
  final Function(List<String>) selected;
  final ShapeDecoration decoration;

  GroupSelector({this.selected, this.decoration});

  @override
  _GroupSelectorState createState() => _GroupSelectorState();
}

class _GroupSelectorState extends State<GroupSelector> {
  final colorMain = Color.fromRGBO(0, 73, 144, 1);

  List<String> tagsList = [];
  List<String> selectedReportList = List<String>();
  List<bool> isSelected = [];

  @override
  initState() {
    super.initState();
    Firestore.instance
        .collection('Info')
        .document("info")
        .get()
        .then((snapshot) {
      setState(() {
        List tags = snapshot.data['Tags'].cast<String>();
        this.tagsList = tags;
        tags.forEach((f) => isSelected.add(false));
        widget.selected(tags);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var sizeHeight = SizeConfig.blockSizeVertical;
    var sizeWidth = SizeConfig.blockSizeHorizontal;
    return ToggleButtons(
      children: _buildChoiceList(),
      borderColor: Colors.transparent,
      fillColor: Colors.transparent,
      color: Colors.transparent,
      renderBorder: false,
      splashColor: Colors.transparent,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = !isSelected[buttonIndex];
            } else {
              isSelected[buttonIndex] = false;
            }
          }

          isSelected.asMap().forEach((index, value) {
            value
                ? selectedReportList.add(tagsList[index])
                : selectedReportList.remove(tagsList[index]);
          });

          selectedReportList.length != 0
              ? widget.selected(selectedReportList)
              : widget.selected(tagsList);
        });
      },
      isSelected: isSelected,
    );
  }

  _buildChoiceList() {
    List<Widget> choices = List();
    SizeConfig().init(context);
    var sizeHeight = SizeConfig.blockSizeVertical;
    var sizeWidth = SizeConfig.blockSizeHorizontal;

    this.tagsList.asMap().forEach((index, item) {
      choices.add(
        Container(
          width: (sizeWidth*50) - 20,
      
          decoration: widget.decoration != null ? widget.decoration : null,
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                border: isSelected[index]
                    ? Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: sizeWidth * 1,
                        ),
                      )
                    : Border(),
              ),
              margin: EdgeInsets.only(bottom: sizeWidth * 1),
              child: Text(
                item,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: sizeHeight*3, fontWeight: FontWeight.bold),
                textScaleFactor: 1.0,
              ),
            ),
          ),
        ),
      );
    });
    return choices;
  }
}
