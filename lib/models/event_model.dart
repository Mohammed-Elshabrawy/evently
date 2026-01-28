class Event {
  String id, image, name, title, description, time;
  DateTime date;
  bool isFavorite;
  static const String collectionName = 'events';

  Event({
    this.id = '',
    required this.image,
    required this.name,
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    this.isFavorite = false,
  });

  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'],
        image: data['image'],
        name: data['name'],
        title: data['title'],
        description: data['description'],
        time: data['time'],
        date: DateTime.fromMillisecondsSinceEpoch(data['date']),
        isFavorite: data['isFavorite'],
      );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'title': title,
      'description': description,
      'time': time,
      'date': date.millisecondsSinceEpoch, //int
      'isFavorite': isFavorite,
    };
  }
}
