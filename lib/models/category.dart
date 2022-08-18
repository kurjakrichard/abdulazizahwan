class Category {
  int? _id;
  String? _name;
  String? _description;

  Category(this._name, this._description);
  Category.withId(this._id, this._name, this._description);

  get id => _id;
  get name => _name;
  set name(value) => _name = value;
  get description => _description;
  set description(value) =>
      value.toString().length <= 255 ? _description = value : null;

//Convert a Note object to a Map opject
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['description'] = _description;

    return map;
  }

//Extract a Note object to a Map object
  Category.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _description = map['description'];
  }
}
