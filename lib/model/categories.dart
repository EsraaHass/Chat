class RoomCategory {
  String id;

  String name;

  String imageName;

  RoomCategory({required this.id, required this.name, required this.imageName});

  static List<RoomCategory> getRoomCategory() {
    return [
      RoomCategory(id: 'movies', name: 'movies', imageName: 'movies.jpg'),
      RoomCategory(id: 'music', name: 'music', imageName: 'music.jpg'),
      RoomCategory(id: 'sport', name: 'sport', imageName: 'sport.jpg'),
    ];
  }
}
