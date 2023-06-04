
import 'package:dart_aluno_cli/models/aluno.dart';

abstract class AlunosRepository {
  // Classe para consumir api
  // Classe sem regras de negocio envolvida
  Future<List<Aluno>> findAll();


}