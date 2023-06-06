// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dart_aluno_cli/models/courses.dart';

import 'address.dart';

class AlunoModel {
  // Atributos
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Courses> courses;
  final Address address;

  // Construtor
  AlunoModel({
    this.id,
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

  factory AlunoModel.fromMap(Map<String, dynamic> map) {
    return AlunoModel(
      id: (map['id'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      age: (map['age'] ?? 0) as int,
      nameCourses: List<String>.from((map['nameCourses'])),
      courses: map['courses']
              ?.map<Courses>((courseMap) => Courses.fromMap(courseMap))
              .toList() ??
          <Courses>{},
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
    );
  }

  factory AlunoModel.fromJson(String source) =>
      AlunoModel.fromMap(jsonDecode(source));
}
