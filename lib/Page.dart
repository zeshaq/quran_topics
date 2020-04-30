class Page {

  int _id;
  int _number;
  int _surah_id;
  String _title;
  int _nextpageid;
  int _prevpageid;

  Page(this._title, this._nextpageid,this._surah_id,this._number,this._prevpageid );

  Page.withId(this._id, this._title,this._surah_id,this._number,this._nextpageid,this._prevpageid);

  int get id => _id;

  String get title => _title;
  int get number => _number;
  int get surah_id => _surah_id;
  int get nextpageid => _nextpageid;
  int get prevpageid => _prevpageid;




  // Convert  object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['number'] = _number;
    map['surah_id'] = _surah_id;
    map['nextpageid'] = _nextpageid;
    map['prevpageid'] = _prevpageid;
    return map;
  }

  // Extract a Note object from a Map object
  Page.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._number = map['number'];
    this._surah_id = map['surah_id'];
    this._nextpageid = map['nextpageid'];
    this._prevpageid = map['prevpageid'];
  }
  Page.fromJson(Map<String, dynamic> json) {
    this._id = json['id'];
    this._title = json['title'];
    this._number = json['number'];
    this._surah_id = json['surah_id'];
    this._nextpageid = json['nextpageid'];
    this._prevpageid = json['prevpageid'];
  }


  Map<String, dynamic> toJson() => {
    "id": this._id,
    "title": this._title,
    "number": this._number,
    "surah_id": this._surah_id,
    "nextpageid": this._nextpageid,
    "prevpageid": this._prevpageid,
  };


}