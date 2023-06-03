import 'dart:convert';

import 'package:dart_aluno_cli/models/courses.dart';
import 'address.dart';

class Aluno {
  // Atributos
  final int id;
  final String name;
  final int age;
  final List<String> nameCourses;
  final List<Courses> courses;
  final Address address;

  // Construtor
  Aluno({
    required this.id,
    required this.name,
    required this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> topMap() {
    final mapResult = <String, dynamic>{
      'id': id,
      'name': name,
      'nameCourses': nameCourses,
      'courses': courses.map((courses) => courses.toMap()),
      'address': address.toMap(),
    };
    if (age > 0) {
      mapResult['age'] = age;
    }
    return mapResult;
  }

  String toJson() => jsonEncode(topMap());
  //
  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      nameCourses: map['nameCourses'],
      courses: map['courses']
              ?.map<Courses>((courseMap) => Courses.fromMap(courseMap))
              .ToList() ??
          <Courses>[],
      address: Address.fromMap(map['address'] ?? <String, dynamic>{}),
    );
  }
}
