import 'package:dart_aluno_cli/service/aluno/aluno_service.dart';

void main(List<String> args) async {
  final AlunoService alunoService = AlunoService();
  
  final caminhoArquivo = 'C:/Projetos_Academia_Flutter/Dart/new_project_aluno_cli/dart_aluno_cli/Alunos.csv';
  print('Inciando cadastro de aluno');
  await alunoService.salvarAluno(caminhoArquivo);
  print('Cadastro de aluno finalizado');
  
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
