import 'package:dart_aluno_cli/service/aluno_service.dart';

void main(List<String> args) async{
  final AlunoService alunoService = AlunoService();

  final alunos = await alunoService.findAll();
  print(alunos);
}