
import 'package:dart_aluno_cli/repository/aluno_repository_impl.dart';
import '../models/aluno.dart';

class AlunoService { 
  Future<List<Aluno>> findAll() async{
    final _alunosRepository = AlunoRepositoryImpl();

    return await _alunosRepository.findAll();
  }
}