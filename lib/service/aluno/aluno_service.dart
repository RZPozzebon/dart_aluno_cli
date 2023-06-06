import 'dart:io';
import 'package:dart_aluno_cli/models/address.dart';
import 'package:dart_aluno_cli/models/city.dart';
import 'package:dart_aluno_cli/models/phone.dart';
import 'package:dart_aluno_cli/repository/produto/produto_repository.dart';
import '../../models/aluno_model.dart';
import '../../models/courses.dart';
import '../../repository/aluno/aluno_repository_impl.dart';

class AlunoService {
  final _alunosRepository = AlunoRepositoryImpl();
  final _produtoRepository = ProdutoRepository();

  Future<List<AlunoModel>> findAll() async {
    return await _alunosRepository.findAll();
  }

  Future<void> salvarAluno(String caminhoArquivo) async {
    final arquivoData = File(caminhoArquivo).readAsLinesSync();
    List<Courses>cursos = [];
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
}
