import 'dart:convert';
import 'package:dart_aluno_cli/models/aluno.dart';
import 'package:dart_aluno_cli/repository/alunos_repository.dart';
import 'package:http/http.dart' as http;

class AlunoRepositoryImpl implements AlunosRepository {
  @override
  Future<List<Aluno>> findAll() async {
    final result = await http.get(Uri.parse('http://localhost:8080/students'));

    final alunoMap = jsonDecode(result.body);

    return alunoMap.map<Aluno>(
      (alunoL) {
        return Aluno.fromMap(alunoL);
      },
    ).toList();
  }
}
