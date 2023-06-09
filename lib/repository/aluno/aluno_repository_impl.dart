import 'dart:convert';
import 'package:dart_aluno_cli/models/aluno_model.dart';
import 'package:http/http.dart' as http;
import 'alunos_repository.dart';

class AlunoRepositoryImpl implements AlunosRepository {
  @override
  Future<List<AlunoModel>> findAll() async {
    final result = await http.get(Uri.parse('http://localhost:8080/students'));

    final alunoMap = jsonDecode(result.body);

    return alunoMap.map<AlunoModel>(
      (alunoL) {
        return AlunoModel.fromMap(alunoL);
      },
    ).toList();
  }

  @override
  Future<void> salvaAluno(AlunoModel aluno) async {
    final alunoSalvoResult = await http.post(
        Uri.parse('http://localhost:8080/students'),
        body: aluno.toJson(),
        headers: {'content-type': 'application/json'});

    if (alunoSalvoResult.statusCode != 200) throw UnimplementedError();
  }
  
  @override
  Future<void> alterarAluno(AlunoModel aluno) async {
    final alunoSalvoResult = await http.put(
        Uri.parse('http://localhost:8080/students/${aluno.id}'),
        body: aluno.toJson(),
        headers: {'content-type': 'application/json'});

    if (alunoSalvoResult.statusCode != 200) throw UnimplementedError();
  }
  
  @override
  Future<void> deletarAluno(int idAluno) async{
    final alunoSalvoResult = await http.delete(
        Uri.parse('http://localhost:8080/students/$idAluno'));

    if (alunoSalvoResult.statusCode != 200) throw UnimplementedError();
  }
  
  @override
  Future<AlunoModel> findById(int id) {
    // TODO: implement findById
    throw UnimplementedError();
  }
}
