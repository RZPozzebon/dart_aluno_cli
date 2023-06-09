import 'dart:convert';
import 'package:dart_aluno_cli/models/aluno_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'alunos_repository.dart';

class AlunoDioRepositoryImpl implements AlunosRepository {
  @override
  Future<List<AlunoModel>> findAll() async {
    try {
      final response = await Dio().get('http://localhost:8080/students');

      if (response.data.isEmpty) {
        throw Exception('Alunos não encontrados');
      }

      return response.data.map<AlunoModel>(
        (alunoL) {
          return AlunoModel.fromMap(alunoL);
        },
      ).toList();
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<AlunoModel> findById(int id) async {
    try {
      final response = await Dio().get('http://localhost:8080/students/$id');

      if (response.data.isEmpty) {
        throw Exception();
      }
      return AlunoModel.fromMap(response.data);
    } on DioError catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> salvaAluno(AlunoModel aluno) async {
    try {
      Dio().post('http://localhost:8080/students', data: aluno.toMap());
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<void> alterarAluno(AlunoModel aluno) async {
    try {
      Dio().put('http://localhost:8080/students/${aluno.id}',
          data: aluno.toMap());
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<void> deletarAluno(int idAluno) async {
    try {
      Dio().put('http://localhost:8080/students/$idAluno');
    } on DioError catch (e) {
      print(e);
      throw Exception();
    }
  }
}
