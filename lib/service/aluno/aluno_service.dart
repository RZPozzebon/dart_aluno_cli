import 'dart:io';
import 'package:dart_aluno_cli/models/address.dart';
import 'package:dart_aluno_cli/models/city.dart';
import 'package:dart_aluno_cli/models/phone.dart';
import 'package:dart_aluno_cli/repository/produto/produto_repository.dart';
import '../../models/aluno_model.dart';
import '../../models/courses.dart';
import '../../repository/aluno/aluno_dio_repository_impl.dart';

class AlunoService {
  final _alunosRepository = AlunoDioRepositoryImpl();
  final _produtoRepository = ProdutoRepository();

  Future<List<AlunoModel>> findAll() async {
    return await _alunosRepository.findAll();
  }

  Future<void> salvarAluno(String caminhoArquivo) async {
    final arquivoData = File(caminhoArquivo).readAsLinesSync();
    List<Courses> cursos = [];
    try {
      for (var element in arquivoData) {
        final aluno = element.split(';');

        final cursoMap = aluno[2].split(',').map((e) => e.trim()).toList();

        for (var element in cursoMap) {
          final curso = await _produtoRepository.findByName(cursoMap[0]);
          curso.isStudent = true;
          cursos.add(curso);
        }

        final alunoModel = AlunoModel(
          name: aluno[0],
          age: int.parse(aluno[1]),
          nameCourses: aluno,
          courses: cursos,
          address: Address(
            street: aluno[3],
            number: int.parse(aluno[4]),
            zipCode: aluno[5],
            city: City(
              id: 1,
              name: aluno[6],
            ),
            phone: Phone(
              ddd: int.parse(aluno[7]),
              phone: aluno[8],
            ),
          ),
        );
        await _alunosRepository.salvaAluno(alunoModel);
        print('-------------------');
        print('Aluno adicionado');
      }
    } on Exception catch (e) {
      print('Falha ao inserir aluno print');
      throw Exception('Falha ao inserir aluno');
    }
  }

  Future<void> AlterarAluno(String caminhoArquivo, int idAluno) async {
    try {
      List<Courses> cursos = [];

      // ignore: unnecessary_null_comparison
      if (idAluno == null) {
        throw Exception('Favor informar um id para alterar o aluno');
      }

      final arquivoData = File(caminhoArquivo).readAsLinesSync();
      print('Aguarde, atualizando dados do aluno');

      if (arquivoData.length > 1) {
        throw Exception('Por favor informe somente um aluno no arquivo');
      } else if (arquivoData.isEmpty) {
        throw Exception('Por favor informe um aluno no arquivo');
      }

      final data = arquivoData.first;
      final aluno = data.split(';');
      final cursoMap = aluno[2].split(',').map((e) => e.trim()).toList();

      for (var element in cursoMap) {
        final curso = await _produtoRepository.findByName(cursoMap[0]);
        curso.isStudent = true;
        cursos.add(curso);
      }
      // Cria o objeto aluno
      final alunoModel = AlunoModel(
        name: aluno[0],
        age: int.parse(aluno[1]),
        nameCourses: aluno,
        courses: cursos,
        address: Address(
          street: aluno[3],
          number: int.parse(aluno[4]),
          zipCode: aluno[5],
          city: City(
            id: 1,
            name: aluno[6],
          ),
          phone: Phone(
            ddd: int.parse(aluno[7]),
            phone: aluno[8],
          ),
        ),
      );
      //Altera o aluno
      await _alunosRepository.alterarAluno(alunoModel);
      print('-------------------');
      print('Aluno alterado com sucesso');
    } on Exception catch (e) {
      //print('Falha ao alterar aluno print');
      throw Exception('Falha ao alterar aluno. Erro: ' + e.toString());
    }
  }

  Future<void> deletarAluno(int idAluno) async {
    try {
      await _alunosRepository.deletarAluno(idAluno);
      print('Aluno Deletado com sucesso...');
    } on Exception catch (e) {
      print('Falha ao deletar aluno. Erro: ' + e.toString());
    }
  }
}
