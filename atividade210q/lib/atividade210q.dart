import 'dart:math';
import 'dart:io';
import 'dart:async';

class Questao1 {
  int targetNumber = 0;
  int attempts = 0;
  String message = "";
  final _random = Random();

  void startNewGame() {
    targetNumber = _random.nextInt(100) + 1;
    attempts = 0;
    message = 'Tente adivinhar o número entre 1 e 100!';
    String? input = stdin.readLineSync();
    while (input != 'sair') {
      checkGuess(input!);
      print(message);
      input = stdin.readLineSync();
    }
    print('O número era: $targetNumber');
  }

  void checkGuess(String input) {
    final guess = int.tryParse(input) ?? 0;
    if (guess < 1 || guess > 100) {
      message = 'O número deve estar entre 1 e 100!';
      return;
    }
    
    attempts++;
    if (guess < targetNumber) {
      message = 'O número é maior! Tentativas: $attempts';
    } else if (guess > targetNumber) {
      message = 'O número é menor! Tentativas: $attempts';
    } else {
      message = 'Parabéns! Você acertou em $attempts tentativas!';
    }
  }
}

class Questao2 {
  final double usdToBRL = 5.2;
  final double eurToBRL = 5.7;
  final double brlToUSD = 1 / 5.2;
  final double brlToEUR = 1 / 5.7;
  
  String selectedCurrencyFrom = 'BRL';
  String selectedCurrencyTo = 'USD';
  String conversionMessage = '';

  double convertCurrency(double value) {
    if (value <= 0) {
      conversionMessage = 'Por favor, insira um valor válido para conversão.';
      return 0.0;
    }

    double convertedValue = 0.0;

    if (selectedCurrencyFrom == 'BRL' && selectedCurrencyTo == 'USD') {
      convertedValue = value * brlToUSD;
    } else if (selectedCurrencyFrom == 'BRL' && selectedCurrencyTo == 'EUR') {
      convertedValue = value * brlToEUR;
    } else if (selectedCurrencyFrom == 'USD' && selectedCurrencyTo == 'BRL') {
      convertedValue = value * usdToBRL;
    } else if (selectedCurrencyFrom == 'EUR' && selectedCurrencyTo == 'BRL') {
      convertedValue = value * eurToBRL;
    } else if (selectedCurrencyFrom == 'USD' && selectedCurrencyTo == 'EUR') {
      convertedValue = value * (eurToBRL / usdToBRL);
    } else if (selectedCurrencyFrom == 'EUR' && selectedCurrencyTo == 'USD') {
      convertedValue = value * (usdToBRL / eurToBRL);
    }

    conversionMessage = 'Resultado da conversão: ${convertedValue.toStringAsFixed(2)}';
    return convertedValue;
  }
}

class Questao3 {
  final bool includeSpecialCharacters;

  Questao3({this.includeSpecialCharacters = false});

  String generatePassword(int length) {
    if (length <= 0) {
      return 'Por favor, insira um tamanho válido.';
    }

    const String lowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const String upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String digits = '0123456789';
    const String specialChars = '!@#\$%^&*()_-+=<>?';

    String characters = lowerCase + upperCase + digits;
    if (includeSpecialCharacters) {
      characters += specialChars;
    }

    Random random = Random();
    String password = '';
    for (int i = 0; i < length; i++) {
      password += characters[random.nextInt(characters.length)];
    }

    return password;
  }
}

class Questao4 {
  List<String> namesList = [];
  String? selectedName;
  final Random _random = Random();

  void addName(String name) {
    if (name.isNotEmpty) {
      namesList.add(name);
      print('Nome "$name" adicionado!');
    } else {
      print('Nome inválido!');
    }
  }

  void pickRandomName() {
    if (namesList.isNotEmpty) {
      int randomIndex = _random.nextInt(namesList.length);
      selectedName = namesList[randomIndex];
      print('Nome sorteado: $selectedName');
    } else {
      print('A lista está vazia!');
    }
  }

  void showNames() {
    if (namesList.isNotEmpty) {
      print('Nomes adicionados:');
      namesList.forEach(print);
    } else {
      print('Nenhum nome foi adicionado ainda.');
    }
  }

  void start() {
    while (true) {
      print('\n1. Adicionar Nome');
      print('2. Realizar Sorteio');
      print('3. Exibir Nomes');
      print('4. Sair');
      stdout.write('Escolha uma opção: ');
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          stdout.write('Digite o nome: ');
          String? name = stdin.readLineSync()?.trim();
          if (name != null) addName(name);
          break;
        case '2':
          pickRandomName();
          break;
        case '3':
          showNames();
          break;
        case '4':
          print('Saindo...');
          return;
        default:
          print('Opção inválida!');
      }
    }
  }
}

class Questao5 {
  final List<String> _tasks = [];

  void addTask() {
    stdout.write('Digite a nova tarefa: ');
    String? task = stdin.readLineSync()?.trim();
    if (task != null && task.isNotEmpty) {
      _tasks.add(task);
      print('Tarefa "$task" adicionada!');
    } else {
      print('Tarefa inválida!');
    }
  }

  void removeCompletedTasks() {
    _tasks.clear();
    print('Todas as tarefas concluídas foram removidas!');
  }

  void showTasks() {
    if (_tasks.isNotEmpty) {
      print('Lista de tarefas:');
      for (var i = 0; i < _tasks.length; i++) {
        print('${i + 1}. ${_tasks[i]}');
      }
    } else {
      print('Nenhuma tarefa disponível.');
    }
  }

  void run() {
    while (true) {
      print('\n1. Adicionar Tarefa');
      print('2. Exibir Tarefas');
      print('3. Remover Todas as Tarefas');
      print('4. Sair');
      stdout.write('Escolha uma opção: ');
      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          addTask();
          break;
        case '2':
          showTasks();
          break;
        case '3':
          removeCompletedTasks();
          break;
        case '4':
          print('Saindo...');
          return;
        default:
          print('Opção inválida!');
      }
    }
  }
}


class Questao6 {
  void calculateIMC() {
    stdout.write('Digite seu peso (kg): ');
    double? weight = double.tryParse(stdin.readLineSync() ?? '');

    stdout.write('Digite sua altura (m): ');
    double? height = double.tryParse(stdin.readLineSync() ?? '');

    if (weight == null || height == null || weight <= 0 || height <= 0) {
      print('Por favor, insira valores válidos para peso e altura.');
      return;
    }

    double imc = weight / (height * height);
    String category;

    if (imc < 18.5) {
      category = 'Abaixo do peso';
    } else if (imc < 24.9) {
      category = 'Peso normal';
    } else if (imc < 29.9) {
      category = 'Sobrepeso';
    } else {
      category = 'Obesidade';
    }

    print('IMC: ${imc.toStringAsFixed(2)}');
    print('Categoria: $category');
  }
}


class Questao7 {
  String generateAcronym(String phrase) {
    List<String> words = phrase.trim().split(' ');
    String acronym = '';

    for (String word in words) {
      if (word.isNotEmpty) {
        acronym += word[0].toUpperCase();
      }
    }
    return acronym;
  }
}

class ContaBancaria {
  double saldo;

  ContaBancaria({this.saldo = 0.0});

  void depositar(double valor) {
    if (valor > 0) {
      saldo += valor;
      print('Depósito de R\$ $valor realizado com sucesso!');
    } else {
      print('Valor de depósito deve ser positivo!');
    }
  }

  bool sacar(double valor) {
    if (valor > 0 && valor <= saldo) {
      saldo -= valor;
      print('Saque de R\$ $valor realizado com sucesso!');
      return true;
    } else {
      print('Saldo insuficiente ou valor de saque inválido!');
      return false;
    }
  }

  double consultarSaldo() {
    return saldo;
  }
}

class Questao8 {
  final ContaBancaria _conta;

  Questao8() : _conta = ContaBancaria();

  void iniciar() {
    print('Bem-vindo ao simulador de conta bancária!');
    bool continuar = true;

    while (continuar) {
      print('\nEscolha uma opção:');
      print('1. Depositar');
      print('2. Sacar');
      print('3. Consultar Saldo');
      print('4. Sair');
      String? opcao = stdin.readLineSync();

      switch (opcao) {
        case '1':
          _depositar();
          break;
        case '2':
          _sacar();
          break;
        case '3':
          _consultarSaldo();
          break;
        case '4':
          continuar = false;
          print('Saindo do simulador...');
          break;
        default:
          print('Opção inválida!');
      }
    }
  }

  void _depositar() {
    print('Digite o valor para depósito:');
    double? valor = _lerValor();
    if (valor != null) {
      _conta.depositar(valor);
    } else {
      print('Valor inválido para depósito!');
    }
  }

  void _sacar() {
    print('Digite o valor para saque:');
    double? valor = _lerValor();
    if (valor != null) {
      _conta.sacar(valor);
    } else {
      print('Valor inválido para saque!');
    }
  }

  void _consultarSaldo() {
    print('Saldo atual: R\$ ${_conta.consultarSaldo().toStringAsFixed(2)}');
  }

  double? _lerValor() {
    String? valorStr = stdin.readLineSync();
    if (valorStr != null) {
      double? valor = double.tryParse(valorStr);
      if (valor != null && valor > 0) {
        return valor;
      }
    }
    return null;
  }
}

class Questao9 {
  String _currentTime = '';

  void _atualizarHora() {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      DateTime agora = DateTime.now();
      _currentTime = '${agora.hour.toString().padLeft(2, '0')}:'
          '${agora.minute.toString().padLeft(2, '0')}:'
          '${agora.second.toString().padLeft(2, '0')}';
      _exibirHora();
    });
  }

  void _exibirHora() {
    stdout.write('\r$_currentTime'); // Atualiza a hora na mesma linha
  }

  void iniciar() {
    print('Relógio Digital');
    _atualizarHora();
  }
}

class Questao10 {
  final Random _random = Random();
  String _userChoice = '';
  String _computerChoice = '';
  String _result = '';

  String _getComputerChoice() {
    int choice = _random.nextInt(3); // 0 - Pedra, 1 - Papel, 2 - Tesoura
    if (choice == 0) {
      return 'Pedra';
    } else if (choice == 1) {
      return 'Papel';
    } else {
      return 'Tesoura';
    }
  }

  void _determineWinner() {
    if (_userChoice == _computerChoice) {
      _result = 'Empate!';
    } else if ((_userChoice == 'Pedra' && _computerChoice == 'Tesoura') ||
        (_userChoice == 'Papel' && _computerChoice == 'Pedra') ||
        (_userChoice == 'Tesoura' && _computerChoice == 'Papel')) {
      _result = 'Você venceu!';
    } else {
      _result = 'Você perdeu!';
    }
  }

  void _makeChoice(String choice) {
    _userChoice = choice;
    _computerChoice = _getComputerChoice();
    _determineWinner();
  }

  void _resetGame() {
    _userChoice = '';
    _computerChoice = '';
    _result = '';
  }

  void iniciar() {
    print('Bem-vindo ao jogo Pedra, Papel e Tesoura!');
    bool continuar = true;

    while (continuar) {
      print('\nEscolha uma opção:');
      print('1. Pedra');
      print('2. Papel');
      print('3. Tesoura');
      print('4. Sair');

      String? opcao = stdin.readLineSync();

      switch (opcao) {
        case '1':
          _makeChoice('Pedra');
          break;
        case '2':
          _makeChoice('Papel');
          break;
        case '3':
          _makeChoice('Tesoura');
          break;
        case '4':
          continuar = false;
          print('Saindo do jogo...');
          break;
        default:
          print('Opção inválida, por favor escolha novamente.');
      }

      if (opcao != '4') {
        _exibirResultado();
        print('Deseja jogar novamente? (s/n)');
        String? jogarNovamente = stdin.readLineSync();
        if (jogarNovamente?.toLowerCase() != 's') {
          continuar = false;
          print('Saindo do jogo...');
        } else {
          _resetGame();
        }
      }
    }
  }

  void _exibirResultado() {
    print('Sua escolha: $_userChoice');
    print('Escolha do computador: $_computerChoice');
    print('Resultado: $_result');
  }
}
