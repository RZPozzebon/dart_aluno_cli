import 'package:dart_aluno_cli/service/aluno/aluno_service.dart';

void main(List<String> args) async {
  try {
    final AlunoService alunoService = AlunoService();

    final caminhoArquivo =
        'C:/Projetos_Academia_Flutter/Dart/new_project_aluno_cli/dart_aluno_cli/Alunos copy.csv';
    await alunoService.deletarAluno(6);

    final alunos = await alunoService.findAll();
    print('Quantidade de alunos: ${alunos.length}');
    print('Nome dos alunos:');
    alunos.forEach(
      (element) {
        print(
            'ID do aluno: ${element.id} Nome : ${element.name}, idade : ${element.age}');
      },
    );
  } on Exception catch (e) {
    print(e.toString());
  }
}
