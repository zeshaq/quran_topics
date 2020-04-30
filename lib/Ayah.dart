import 'package:flutter/cupertino.dart';

class Ayah {

  int _id;
  String _text;
  int _ayah_number;
  String _audio;
  int _page_id;
  int _surah_id;



  Ayah(this._text );

  Ayah.withId(this._id, this._text);

  int get id => _id;

  String get text => _text;
  int  get ayah_number => _ayah_number;
  String get audio => _audio;
  int get page_id => _page_id;
  int get surah_id => _surah_id;





  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['text'] = text;
    map['audio'] = audio;
    map['ayah_number'] = ayah_number;
    map['page_id'] = page_id;
    map['surah_id'] = surah_id;

    return map;
  }

  // Extract a Note object from a Map object
  Ayah.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._text = map['text'];
    this._audio = map['audio'];
    this._ayah_number = map['ayah_number'];
    this._page_id = map['page_id'];
    this._surah_id = map['surah_id'];
  }

  Ayah.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._text = json['text'];
    this._audio = json['audio'];
    this._ayah_number = json['ayah_number'];
    this._page_id = json['page_id'];
    this._surah_id = json['surah_id'];
  }


  Map<String, dynamic> toJson() => {
    "id": this._id,
    "text": this._text,
    "audio": this._audio,
    "ayah_number": this._ayah_number,
    "page_id": this._page_id,
    "surah_id": this._surah_id,

  };


}