// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dart_aluno_cli/models/courses.dart';

import 'address.dart';

class Aluno {
  // Atributos
  final int id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Courses> courses;
  final Address address;

  // Construtor
  Aluno({
    required this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final mapResult = <String, dynamic>{
      'id': id,
      'name': name,
      'nameCourses': nameCourses,
      'courses': courses.map((course) => course.toMap()).toList(),
      'address': address.toMap(),
    };

    if (age != null) {
      mapResult['age'] = age;
    }

    return mapResult;
  }

  String toJson() => jsonEncode(toMap());

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      age: (map['age'] ?? 0) as int,
      nameCourses: List<String>.from((map['nameCourses'])),
      courses: map['courses']
              ?.map((courseMap) => Courses.fromMap(courseMap))
              .toList() ??
          <Courses>{},
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
    );
  }

  factory Aluno.fromJson(String source) => Aluno.fromMap(jsonDecode(source));
}
