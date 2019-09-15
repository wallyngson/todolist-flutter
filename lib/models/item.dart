class Item {
  String title;
  bool done;

  Item({this.title, this.done}); // constructor

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;

    return data;
  }

}