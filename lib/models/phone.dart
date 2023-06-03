// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class Phone {
  // Atributos
  final String ddd;
  final String phone;

  //Construtor
  Phone({
    required this.ddd,
    required this.phone,
  });

  //Serealização e Deserialização

  // 1- Criar o mapa de Map<String,dynamic>)
//   2 - Criar metodo para serealizar o dados para json
  Map<String, dynamic> toMap() {
    return {
      'ddd': ddd,
      'phone': phone,
    };
  }

  String toJson() => jsonEncode(toMap());

  //Deserialização
  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      ddd: map['ddd']?? '',
      phone: map['phone']?? '',
    );
  }

  factory Phone.fromJson(String json){
    final jsonMap = jsonDecode(json);
    return Phone.fromMap(jsonMap);
  }
}
