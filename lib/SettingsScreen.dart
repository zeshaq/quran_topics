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
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsScreen extends StatefulWidget {




  const SettingsScreen();
  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {


  QuranDatabase databaseHelper = QuranDatabase();




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
  Future updatePage() async{
    var url = 'http://192.168.0.102/islam/public/json/pages';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {
       databaseHelper.repopulatePages(data);

    });

    showCenterShortToast();
  }
  Future updateAyah() async{
    var url = 'http://192.168.0.102/islam/public/json/ayahs';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {
      databaseHelper.repopulateAyahs(data);

    });

    showCenterShortToast();
  }
  void showCenterShortToast() {
    Fluttertoast.showToast(
        msg: " updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
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


      ),



        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: incFontSize,
                    child: new Text("increase"),
                  ),
                  new RaisedButton(
                    onPressed: decFontSize,
                    textColor: Colors.white,
                    color: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Decrease ",
                    ),
                  ),
                ],
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[


                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: updatePage,
                    child: new Text("update pages"),
                  ),

                ],
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[


                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: updateAyah,
                    child: new Text("update ayahs"),
                  ),

                ],
              ),

            ],
          ),
        ));


  }

















}