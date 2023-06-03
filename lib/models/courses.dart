// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Courses {
  // Atributos
  final int id;
  final String name;
  final bool isStudent;

  //Construtor
  Courses({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  // Serealização e Deserialização

  Map<String, dynamic> toMap() {
    return{
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  String toJson() => jsonEncode(toMap());
  
  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      isStudent: (map['isStudent'] ?? false) as bool,
    );
  }  

  factory Courses.fromJson(String json) => Courses.fromMap(jsonDecode(json));
}
