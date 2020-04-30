import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'Main.dart';
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



class QuranPageAyahsScreen extends StatefulWidget {

  final  Page mypage;


  const QuranPageAyahsScreen(this.mypage);
  @override
  State<StatefulWidget> createState() {
    return QuranPageAyahsScreenState();
  }
}

class QuranPageAyahsScreenState extends State<QuranPageAyahsScreen> {
  QuranDatabase databaseHelper = QuranDatabase();
  List<Ayah> ayahList;
  int count = 0;
  double custFontSize = 0;






  void incFontSize() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    double oldfontsize = prefs.getDouble('fontsize');
    double newfontsize = oldfontsize+1;
    prefs.setDouble('fontsize', newfontsize);

    setState(() {
      custFontSize = newfontsize;


    });
  }
  void decFontSize() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    double oldfontsize = prefs.getDouble('fontsize');
    double newfontsize = oldfontsize-1;
    prefs.setDouble('fontsize', newfontsize);

    setState(() {
      custFontSize = newfontsize;


    });
  }




  @override
  Widget build(BuildContext context) {
    if (ayahList == null) {
      ayahList = List<Ayah>();
      updateListView(widget.mypage.id.toString());


    }

    setInitFontSize();
    void gotonext(nextpageid) {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {




        Future<Page> pfuture = databaseHelper.getPageObj(nextpageid);
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
    void addBookMark(pageid) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setInt('bookmark', pageid);
    }

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

        title: Text('${widget.mypage.surah_id.toString()}- ${widget.mypage.number.toString()}',
          style: TextStyle(

              fontSize: 18, height: 1.7),

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

          IconButton(
            icon:Icon(
              Icons.list,
              color:Colors.white,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context)=> QuranPageScreen(widget.mypage.surah_id),
                ),
              );
            },
          ),

          IconButton(
            icon:Icon(
              Icons.star_border,
              color:Colors.white,
            ),
            onPressed: (){
              addBookMark(widget.mypage.id);

            },
          ),

          IconButton(
            icon:Icon(
              Icons.skip_previous,
              color:Colors.white,
            ),
            onPressed: (){
              gotonext(widget.mypage.prevpageid);

            },
          ),
          IconButton(
            icon:Icon(
              Icons.skip_next,
              color:Colors.white,
            ),
            onPressed: (){
              gotonext(widget.mypage.nextpageid);

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
       return Container(
         color: Colors.white,


child:Card(
  child:Container(
    padding: EdgeInsets.only(top:21.0,left:10,right:10,bottom:10),
         child: Row(



           children:<Widget>[



               Text(this.ayahList[position].ayah_number.toString(),
                   style: TextStyle(
                       fontFamily: 'Scheherazade',
                       fontSize: 15, height: 1.7),
                   textDirection: TextDirection.rtl
               ),


             Expanded(
             child:Text(this.ayahList[position].text,
               style: TextStyle(
                   fontFamily: 'Scheherazade',
                   fontSize: custFontSize, height: 2.3,letterSpacing: 3),
               textDirection: TextDirection.rtl
           ),
             )
]

         ),
)
)
       );
     },
   );
 }
/*  ListView getItemListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,

          child: Container(

            child:Row(
              children: [
                Text(this.ayahList[position].ayah_number.toString()),
                Text(this.ayahList[position].text.toString(),

                    style: TextStyle(
                        fontFamily: 'Scheherazade',
                        fontSize: 25,height:1.7),
                    textDirection: TextDirection.rtl
                ),

              ],
            ),

          ),
        );
      },
    );
  }*/


  void setInitFontSize() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool CheckValue = prefs.containsKey('fontsize');

    if(CheckValue)
    {
      double intValue = prefs.getDouble('fontsize');
      setState(() {
        custFontSize = intValue;
      });

    }
    else
    {
      prefs.setDouble('fontsize', 20);
      setState(() {
        custFontSize = 20;
      });
    }
  }

  void updateListView(itemid) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {




      Future<List<Ayah>> ayahListFuture = databaseHelper.getAyahList(itemid);
      ayahListFuture.then((ayahList) {
        setState(() {

          this.ayahList = ayahList;
          this.count = ayahList.length;


        });
      });
    });
  }










}