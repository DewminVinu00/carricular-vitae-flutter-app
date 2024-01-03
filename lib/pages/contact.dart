class Contact {
  String name;
  String contact;
  String id;

  Contact({
    required this.name,
    required this.contact,
    required this.id,
  });

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'] ?? '',
      contact: map['contact'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact': contact,
      'id': id,
    };
  }
}
