import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'Page.dart';
import 'Ayah.dart';
import 'Surah.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:convert';
class QuranDatabase {

  static QuranDatabase _databaseHelper;    // Singleton PageDatabaseHelper
  static Database _database;                // Singleton Database

  String pages_table = 'pages';
  String ayah_table = 'ayahs';
  String surah_able = 'surahs';


  QuranDatabase._createInstance(); // Named constructor to create instance of PageDatabaseHelper

  factory QuranDatabase() {

    if (_databaseHelper == null) {
      _databaseHelper = QuranDatabase._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {


    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'quran_topic.db';

    ByteData data = await rootBundle.load(join("assets", "quran_topic.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);

    // Open/create the database at a given path
    var qurandb = await openDatabase(path, version: 3);
    return qurandb;
  }




  Future<List<Map<String, dynamic>>> getPageMapList() async {
    Database db = await this.database;


    var result = await db.query(pages_table, orderBy: 'number ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getPageBySurahMapList(int itemId) async {
    Database db = await this.database;


    var result = await db.query(pages_table,

      columns: ["id", "title", "surah_id", "number","nextpageid","prevpageid"],
      where: 'surah_id = ?',
      whereArgs: [itemId],
      orderBy: 'number ASC',
    );
    return result;
  }


Future<Page> getPageObj(itemid) async{
  Database db = await this.database;
  var result = await db.query(pages_table,


    where: 'id = ?',
    whereArgs: [itemid],

  );

  Page pobj = Page.fromMapObject(result.first);
  return pobj;
}






  Future<List<Page>> getPageList() async {

    var pageMapList = await getPageMapList(); // Get 'Map List' from database
    int count = pageMapList.length;         // Count the number of map entries in db table

    List<Page> pageList = List<Page>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      pageList.add(Page.fromMapObject(pageMapList[i]));
    }

    return pageList;
  }

  Future<List<Page>> getPagesBySurahList(int itemId) async {

    var pageMapList = await getPageBySurahMapList(itemId); // Get 'Map List' from database
    int count = pageMapList.length;         // Count the number of map entries in db table

    List<Page> pageList = List<Page>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      pageList.add(Page.fromMapObject(pageMapList[i]));
    }

    return pageList;
  }



  //get ayah

  Future<List<Map<String, dynamic>>> getAyahMapList(itemid) async {
    Database db = await this.database;


    var result = await db.query(ayah_table,

        where: 'page_id = ?',
        whereArgs: [itemid],

        orderBy: 'ayah_number ASC');
    return result;
  }


  Future<List<Map<String, dynamic>>> getPageMap(itemid) async {
    Database db = await this.database;

    String thistable = "pages";
    var result = await db.query(thistable,

      where: 'id = ?',
      whereArgs: [itemid],

    );
    return result;
  }

  Future<List<Page>> getPage(itemid) async {

    var ayahMapList = await getPageMap(itemid); // Get 'Map List' from database
    int count = ayahMapList.length;         // Count the number of map entries in db table


    List<Page> ayahList = List<Page>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      ayahList.add(Page.fromMapObject(ayahMapList[i]));
    }

    return ayahList;
  }









  Future<List<Ayah>> getAyahList(itemid) async {

    var ayahMapList = await getAyahMapList(itemid); // Get 'Map List' from database
    int count = ayahMapList.length;         // Count the number of map entries in db table


    List<Ayah> ayahList = List<Ayah>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      ayahList.add(Ayah.fromMapObject(ayahMapList[i]));
    }



    return ayahList;
  }



  //surahdbhelper

  Future<List<Map<String, dynamic>>> getSurahMapList() async {
    Database db = await this.database;


    var result = await db.query(surah_able, orderBy: 'id ASC');
    return result;
  }


  void createPage(Page newPage) async {

    Database db = await this.database;
    final res = await db.insert('Pages', newPage.toJson());


  }

  void createAyah(Ayah newAyah) async {

    Database db = await this.database;
    final res = await db.insert('Ayahs', newAyah.toJson());


  }





  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Surah>> getSurahList() async {

    var surahMapList = await getSurahMapList(); // Get 'Map List' from database
    int count = surahMapList.length;         // Count the number of map entries in db table

    List<Surah> surahList = List<Surah>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      surahList.add(Surah.fromMapObject(surahMapList[i]));
    }

    return surahList;
  }
  List<Page> pageFromJson(String str) =>
      List<Page>.from(json.decode(str).map((x) => Page.fromJson(x)));


  Future<void> repopulatePages(data) async {
    // Get a reference to the database.
    Database db = await this.database;

    // Remove the Dog from the Database.
    await db.delete(
      pages_table,
      // Use a `where` clause to delete a specific dog.
      where: "id >0",

    );

   (data as List).map((pg) {
      print('Inserting $pg');
      createPage(Page.fromJson(pg));
    }).toList();
  }


  Future<void> repopulateAyahs(data) async {
    // Get a reference to the database.
    Database db = await this.database;

    // Remove the Dog from the Database.
    await db.delete(
      ayah_table,
      // Use a `where` clause to delete a specific dog.
      where: "id >0",

    );

    (data as List).map((pg) {
      print('Inserting $pg');
      createAyah(Ayah.fromJson(pg));
    }).toList();
  }
}