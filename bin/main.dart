import 'dart:io';
import 'package:dart_aluno_cli/service/aluno/aluno_service.dart';

void main(List<String> args) async {
  try {
    final AlunoService _alunoService = AlunoService();
    print('-------Bem vindo ao sistema de consulta de aluno-------');
    print('----------------');
    print('Qual opção deseja utilizar?');
    print('  0- Cadastrar um novo aluno');
    print('  1- Todos os alunos');
    print('  2- Um alunos em específico');
    print('  3- Alterar um aluno');
    print('  4- Deletar um aluno');

    final opcaoEscolhida = int.parse(stdin.readLineSync()!);
    switch (opcaoEscolhida) {
      case 0:
        final caminhoArquivo = stdin.readLineSync() ?? '';
        if (caminhoArquivo.isEmpty) {
          throw Exception('Informe o caminho do arquivo.');
        }
        await _alunoService.salvarAluno(caminhoArquivo);
        break;
      case 1: //Busca todos os alunos
        print('Iniciando busca dos alunos');
        final alunos = await _alunoService.findAll();
        print('------');
        print('Quantidade de alunos: ${alunos.length}');
        print('Lista dos Alunos:');
        for (var element in alunos) {
          await Future.delayed(Duration(seconds: 2));
          print('ID - ${element.id}');
          print('  Nome : ${element.name}, idade : ${element.age}');
        }
        print('Final da busca');
        break;
      case 2: // Filtra id
        print('Selecionando o aluno desejado');
        print('Qual o id do aluno?');
        final idSelecionado = stdin.readLineSync();

        if (idSelecionado!.isEmpty) {
          throw Exception('Favor infomrar um id');
        }

        final aluno = await _alunoService.findById(int.parse(idSelecionado));
        final alunoMap = aluno.toMap();
        print('ID - ${alunoMap['id']}');
        print('  Nome : ${alunoMap['name']}, idade : ${alunoMap['age']}');
        break;
      case 3:
        final caminhoArquivo = stdin.readLineSync() ?? '';
        final idSelecionado = int.parse(stdin.readLineSync()!);
        await _alunoService.AlterarAluno(caminhoArquivo, idSelecionado);
        break;
      case 4:
        final idSelecionado = int.parse(stdin.readLineSync()!);
        await _alunoService.deletarAluno(idSelecionado);
        break;
      default:
    }
  } on Exception catch (e) {
    print(e.toString());
  }
}
