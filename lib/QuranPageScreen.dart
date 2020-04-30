import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'QuranDatabase.dart';
import 'QuranPageAyahsScreen.dart';
import 'QuranHomeScreen.dart';
import 'Surah.dart';
import 'Page.dart';
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





class QuranPageScreen extends StatefulWidget {

  final  surah_id;


const QuranPageScreen(this.surah_id);


  @override
  QuranPageScreenState createState() => QuranPageScreenState();
}

class QuranPageScreenState extends State<QuranPageScreen> {





  QuranDatabase databaseHelper = QuranDatabase();
  List<Page> pageList;
  int count = 0;


  @override
  Widget build(BuildContext context) {

    int myid = 2;
    if (pageList == null) {
      pageList = List<Page>();
      updateListView(widget.surah_id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('0${widget.surah_id} - Pages'),
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
              Icons.apps,
              color:Colors.white,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context)=> QuranHomeScreen(),
                ),
              );
            },
          ),
        ],
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

              title: Text('${this.pageList[position].number.toString()}.${this.pageList[position].title}',
                  style: TextStyle(fontWeight: FontWeight.bold)

              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context)=> QuranPageAyahsScreen(this.pageList[position]),
                  ),
                );
              }


          ),
        );
      },
    );
  }



  void updateListView(int itemId) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Page>> pageListFuture = databaseHelper.getPagesBySurahList(itemId);
      pageListFuture.then((pageList) {
        setState(() {
          this.pageList = pageList;
          this.count = pageList.length;


        });
      });
    });
  }










}