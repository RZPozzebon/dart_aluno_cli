import 'package:dart_aluno_cli/service/aluno_service.dart';

void main(List<String> args) async {
  final AlunoService alunoService = AlunoService();

  final alunos = await alunoService.findAll();

  print('Quantidade de alunos: ${alunos.length}');
  print('Nome dos alunos:');
  alunos.forEach(
    (element) {
      print('Nome : ${element.name}, idade : ${element.age}');
    },
  );

  //print(alunos);
}
