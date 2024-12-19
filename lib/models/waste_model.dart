class Waste {
  final int? id;
  final String name;
  final String type;
  final int weight;
  final String date;

  Waste({
    this.id,
    required this.name,
    required this.type,
    required this.weight,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'weight': weight,
      'date': date,
    };
  }

  factory Waste.fromMap(Map<String, dynamic> map) {
    return Waste(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      weight: map['weight'],
      date: map['date'],
    );
  }
}
