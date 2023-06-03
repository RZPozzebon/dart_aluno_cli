// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class City {
  // Atributos
  final int id;
  final String name;

  // Construtores
  City({
    required this.id,
    required this.name,
  });

  // Serealização e Deserialização do Objeto.

  // Serialização - toMap()
  // 1 - Criar um map
  //  2 - Declarar o toJson()

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  String toJson() => jsonEncode(toMap());

  //Desearilização
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  factory City.fromJson(String json) {
    final jsonMap = jsonDecode(json);
    return City.fromMap(jsonMap);
  }
}
