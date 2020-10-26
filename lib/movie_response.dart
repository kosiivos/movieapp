class Response {
  String _id;
  String _title;
  String _poster;
  String _back;
  String _rating;
  String _views;
  String _overall;

  Response();

  Response.withId(this._id, this._title, this._poster, this._back, this._rating,
      this._views, this._overall);

  String get id => _id;

  String get views => _views;

  String get rating => _rating;

  String get back => _back;

  String get poster => _poster;

  String get title => _title;

  String get overall => _overall;
}
