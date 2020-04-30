class Surah {

  int _id;
  String _name;


  Surah(this._name );

  Surah.withId(this._id, this._name);

  int get id => _id;

  String get name => _name;







  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = name;


    return map;
  }

  // Extract a Note object from a Map object
  Surah.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];

  }
}