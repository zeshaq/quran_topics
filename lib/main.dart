import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'SettingsScreen.dart';
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
import 'QuranPageAyahsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


import 'dart:io';

import 'package:archive/archive.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

const api =
    'http://192.168.0.102';

void main()  => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
      //  appBar: AppBar(title: Text('Islam')),
        body: QuranHomeScreen(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  QuranDatabase databaseHelper = QuranDatabase();

  String _dir;
  void gotobookmark() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int pageid = prefs.getInt('bookmark');

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {




      Future<Page> pfuture = databaseHelper.getPageObj(pageid);
      pfuture.then((pobj) {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder:(context)=> QuranPageAyahsScreen(pobj),
          ),
        );

      });
    });
  }

  Future<bool> _hasToDownloadAssets(String name, String dir) async {
    var file = File('$dir/$name.zip');
    return !(await file.exists());
  }
  Future<File> _downloadFile(String url, String filename, String dir) async {
    var req = await http.Client().get(Uri.parse(url));
    var file = File('$dir/$filename');
    return file.writeAsBytes(req.bodyBytes);
  }
  //download
  Future<void> _downloadAssets() async {

      _dir = (await getApplicationDocumentsDirectory()).path;



    var zippedFile = await _downloadFile(
        'http://192.168.0.102/islam/public/001001.mp3',
        '001001.mp3',
        '$_dir/ab/01');

print(zippedFile.path);


  }





  //




  return ListView(
    children: ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
            title: Text('Quran'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context)=> QuranHomeScreen(),
                ),
              );
            }
        ),
        ListTile(
            title: Text('Settings'),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context)=> SettingsScreen(),
                ),
              );
            }
        ),
        ListTile(
            title: Text('Bookmark'),
            onTap: (){
              gotobookmark();
            }
        ),
        ListTile(
            title: Text('Download'),
            onTap: () async{
              await _downloadAssets();
            }
        ),

      ],
    ).toList(),
  );
}