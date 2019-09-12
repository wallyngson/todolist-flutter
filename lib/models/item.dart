class Item {
  String title;
  bool done;

  Item({this.title, this.done}); // constructor

  Item.fromJSON(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;

    return data;
  }

}