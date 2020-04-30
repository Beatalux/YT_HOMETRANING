import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_hometraining_app/screens/abs_list.dart';
import 'package:youtube_parser/youtube_parser.dart'; //get the ID
import 'package:youtube_hometraining_app/utilities/test_Screen.dart';
import 'dart:io' show Platform;
import 'package:numberpicker/numberpicker.dart';

//
//import 'package:simpletime_picker/constant.dart';
//import 'package:simpletime_picker/scrollable_time_picker.dart';
//import 'package:simpletime_picker/time_picker.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static var rand = new Random();
  var randomImg = rand.nextInt(3);
  List<bool> isSelected = List.generate(7, (_) => false);
  List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];
  Duration initialtimer = new Duration();
  VoidCallback _showBottomSheetCallBack;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currenthour = 0;
  int _currentMin = 0;

//  CupertinoTimerPicker{
//    mode:CupertinoTimerPickerMode.hm,
//  minuteIn

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 200,
            child: new Center(
                child: CupertinoTimerPicker(
                    initialTimerDuration: initialtimer,
                    onTimerDurationChanged: (Duration changedtimer) {
                      setState(() {
                        initialtimer = changedtimer;
                      });
                    },
                    mode: CupertinoTimerPickerMode.hm)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/image$randomImg.jpg'),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  )),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                child: Column(

                  children: <Widget>[
                    //1st container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          //DOCS 작성!
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 8.0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 14.0),
                            child: ToggleButtons(
                              constraints:
                                  BoxConstraints.tight(Size(45.0, 35.0)),
                              children: <Widget>[
                                for (String day in weekdays) WeekdayText(day)
                              ],
                              isSelected: isSelected,
                              onPressed: (int index) {
                                setState(() {
                                  isSelected[index] = !isSelected[index];
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 14.0),
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    NumberPicker.integer(
                                        initialValue: _currenthour,
                                        minValue: 0,
                                        maxValue: 24,
                                        onChanged: (newValue) => setState(
                                            () => _currenthour = newValue)),
                                    Text("시간"),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    NumberPicker.integer(
                                        initialValue: _currentMin,
                                        minValue: 0,
                                        maxValue: 60,
                                        onChanged: (newValue) => setState(
                                            () => _currentMin = newValue)),
                                    Text("분"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          //DOCS 작성!
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '꾸준히 할 운동',
                              style: TextStyle(
                                fontSize: 20.00,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '운동 url',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'copy URL',
                                      ),
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),
                                      onSubmitted:(url){

                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 14.0),
                                child: RaisedButton(
                                  color: Colors.deepPurple,
                                  child: Text(
                                    '저장',
                                    style: TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                  //add url list
                                  onPressed:(){
                                    setState(() {

                                    });
//                                  Navigator.push(
//                                      context, MaterialPageRoute(
//                                    builder:(context){
//                                    return AbslistScreen();
//                                    }
//                                    )
//                                  );

                                  },
                                ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//            Padding(
//              padding:
//                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
//              child: Column(
//                children: <Widget>[
//                  FlatButton(
//                      color: Colors.blueGrey,
//                      onPressed: () {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) {
//                          return AbslistScreen();
//                        }));
//                      },
//                      child: null)
//                ],
//              ),
//            ),

//  Future<RaisedButton> buildRaisedButton(BuildContext context) async {
//    return RaisedButton(
//  onPressed: () async {
//    var result = await TimePicker.pickTime(context,
//        selectedColor: Colors.amber,
//        nonSelectedColor: Colors.black,
//        displayType: DisplayType.dialog,
//        timePickType: TimePickType.hourMinuteSecond,
//        fontSize: 30.0,
//        isTwelveHourFormat: true);
//  });
//  }

Text WeekdayText(String s) {
  return Text(
    s,
    style: TextStyle(
      fontSize: 25.0,
    ),
  );
}
