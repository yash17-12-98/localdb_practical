
class Item {

  int? _id;
  String? _title;
  String? _imagePath;
  bool? _fav;


  Item(this._id, this._title, this._imagePath, [this._fav]);

  // Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  int get id => _id!;

  String get title => _title!;

  String get imagePath => _imagePath!;

  bool get fav => _fav!;


  set title(String newTitle) {

      this._title = newTitle;

  }

  set imagePath(String newPath) {

      this._imagePath = newPath;

  }

  set fav(bool favOne) {

      this._fav = favOne;

  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['imagePath'] = _imagePath;
    map['fav'] = _fav;

    return map;
  }


  Item.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._imagePath = map['imagePath'];
    this._fav = map['fav'];
  }
}









