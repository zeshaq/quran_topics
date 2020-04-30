import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'main.dart';
import 'Surah.dart';
import 'Ayah.dart';
import 'Page.dart';
import 'QuranDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'QuranHomeScreen.dart';
import 'QuranPageScreen.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';

import 'package:shared_preferences/shared_preferences.dart';



class SettingsScreen extends StatefulWidget {




  const SettingsScreen();
  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {







  void incFontSize() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    double oldfontsize = prefs.getDouble('fontsize');
    double newfontsize = oldfontsize+1;
    prefs.setDouble('fontsize', newfontsize);


  }
  void decFontSize() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    double oldfontsize = prefs.getDouble('fontsize');
    double newfontsize = oldfontsize-1;
    prefs.setDouble('fontsize', newfontsize);


  }




  @override
  Widget build(BuildContext context) {






    return Scaffold(
      appBar: AppBar(
        leading:          IconButton(
          icon:Icon(
            Icons.home,
            color:Colors.white,
          ),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:(context)=> MyApp(),
              ),
            );
          },
        ),
        title: Text('Settings'

        ),

        actions: <Widget>[




          IconButton(
            icon:Icon(
              Icons.exposure_plus_1,
              color:Colors.white,
            ),
            onPressed: (){
              incFontSize();

            },
          ),
          IconButton(
            icon:Icon(
              Icons.exposure_neg_1,
              color:Colors.white,
            ),
            onPressed: (){
              decFontSize();

            },
          ),



        ],
      ),



      body: Center(
          child: Text('Hello World')           ),

    );
  }

















}