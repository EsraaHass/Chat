class MyRoom {
  static const String routeName = 'MyRoom';

  String? id;
  String? name;
  String? desc;
  String? catId;

  MyRoom({this.id, this.name, this.desc, this.catId});

  MyRoom.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          name: data['name'],
          desc: data['desc'],
          catId: data['catId'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'catId': catId,
    };
  }
}
