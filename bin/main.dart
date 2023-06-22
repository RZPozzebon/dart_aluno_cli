import 'dart:io';
import 'package:dart_aluno_cli/models/aluno_model.dart';
import 'package:dart_aluno_cli/service/aluno/aluno_service.dart';

// não sei se o certo, mas é só por brincadeira
final AlunoService _alunoService = AlunoService();
void main(List<String> args) async {
  try {
    print('-------Bem vindo ao sistema de consulta de aluno-------');
    print('----------------');
    print('Qual opção deseja utilizar?');
    print('  0- Cadastrar um novo aluno');
    print('  1- Todos os alunos');
    print('  2- Um alunos em específico');
    print('  3- Alterar um aluno');
    print('  4- Deletar um aluno');

    final opcaoEscolhida = 1;
    //int.parse(stdin.readLineSync()!);
    switch (opcaoEscolhida) {
      case 0:
        print('Informe o caminho do arquivo');
        final caminhoArquivo = stdin.readLineSync() ?? '';
        cadastrarAluno(caminhoArquivo);
        break;
      case 1: //Busca todos os alunos
        final alunos = await buscaTodosAlunos();

        for (var element in alunos) {
          await Future.delayed(Duration(seconds: 2));
          print('ID - ${element.id}');
          print('  Nome : ${element.name}, idade : ${element.age}');
        }
        print('-------');
        print('Fim da busca');
        break;
      case 2: // Filtra id
        print('Selecionando o aluno desejado');
        print('Qual o id do aluno?');
        final idSelecionado = stdin.readLineSync();
        final aluno = await buscaAlunoId(idSelecionado!);
        print('ID - ${aluno.id}');
        print('  Nome : ${aluno.name}, idade : ${aluno.age}');
        print('------');
        print('Fim da busca');
        break;
      case 3:
        print('Opção escolhida: Alterar aluno:');
        print('Informe o caminho do arquivo');
        final caminhoArquivo = stdin.readLineSync() ?? '';
        alterarAluno(caminhoArquivo);
        print('Aluno alterado com sucesso');
        break;
      case 4:
        print('Opção escolhida: Deletar aluno:');
        print('  - Informe o id que deseja excluir');
        final idSelecionado = stdin.readLineSync() ?? '';
        deletarAluno(idSelecionado);
        print('Aluno deletado com sucesso');

        break;
      default:
    }
  } on Exception catch (e) {
    print(e.toString());
  }
}

Future<void> cadastrarAluno(String caminhoArquivo) async {
  if (caminhoArquivo.isEmpty) {
    throw Exception('Informe o caminho do arquivo.');
  }
  await _alunoService.salvarAluno(caminhoArquivo);
}

Future<List<AlunoModel>> buscaTodosAlunos() async {
  print('Opção escolhida: Buscar todos os alunos');
  print('Iniciando busca dos alunos');
  final alunos = await _alunoService.findAll();
  print('------');
  print('Quantidade de alunos encontrado: ${alunos.length}');

  return alunos;
}

Future<AlunoModel> buscaAlunoId(String idSelecionado) async {
  print('Opção escolhida: Buscar Aluno ID');
  if (idSelecionado.isEmpty) {
    throw Exception('Favor infomrar um id');
  }
  final aluno = await _alunoService.findById(int.parse(idSelecionado));
  return AlunoModel.fromMap(aluno.toMap());
}

Future<void> alterarAluno(String caminhoArquivo) async {
  print(
      '  - Para alterar o aluno basta informar ele no arquivo e importar o arquivo CSV.');
  print('  - Segundo passo é informar o id do aluno que deseja alterar');
  final idSelecionado = int.parse(stdin.readLineSync()!);
  await _alunoService.AlterarAluno(caminhoArquivo, idSelecionado);
}

void deletarAluno(String idSelecionado) async {
  if (idSelecionado == null) {
    throw Exception('Informar um id para deletar');
  }

  await _alunoService.deletarAluno(int.parse(idSelecionado));
}
//     print('  3- Alterar um aluno');
//     print('  4- Deletar um aluno');
