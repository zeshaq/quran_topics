import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'QuranDatabase.dart';
import 'Surah.dart';
import 'Main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'QuranPageScreen.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'SettingsScreen.dart';




class QuranHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QuranHomeScreenState();
  }
}

class QuranHomeScreenState extends State<QuranHomeScreen> {
  QuranDatabase databaseHelper = QuranDatabase();
  List<Surah> surahList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (surahList == null) {
      surahList = List<Surah>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Home'),
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
        actions: <Widget>[

      IconButton(
      icon:Icon(
        Icons.settings,
        color:Colors.white,
      ),
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:(context)=> SettingsScreen(),
          ),
        );

      },
    ),
    ]
      ),
      body: getItemListView(),

    );
  }

  ListView getItemListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: Text(this.surahList[position].id.toString()),


            title: Text(this.surahList[position].name,
                style: TextStyle(
                    fontFamily: 'Scheherazade',
                    fontSize: 20,
                    height: 1

                ),
                textDirection: TextDirection.rtl
            ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context)=> QuranPageScreen(this.surahList[position].id),
                  ),
                );
              }


          ),
        );
      },
    );
  }



  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Surah>> surahListFuture = databaseHelper.getSurahList();
      surahListFuture.then((ayahList) {
        setState(() {
          this.surahList = ayahList;
          this.count = surahList.length;
        });
      });
    });
  }










}