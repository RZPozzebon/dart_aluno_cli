
import 'package:dart_aluno_cli/models/aluno_model.dart';

abstract class AlunosRepository {
  // Classe para consumir api
  // Classe sem regras de negocio envolvida
  Future<List<AlunoModel>> findAll();

  Future<void> salvaAluno(AlunoModel aluno);
}