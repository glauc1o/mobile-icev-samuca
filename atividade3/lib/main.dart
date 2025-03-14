import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorteador com Histórico',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  
  final List<String> nomesOriginais = ['Melquíades', 'Yan', 'Coxinha', 'Daniel', 'Barradas vulgo lorin do codigo' , 'Cruz', 'Glaucio' , 'Guilherme'];
  
  late List<String> nomesDisponiveis;
  
  List<String> historicoGanhadores = [];
  
  String mensagem = 'Clique no botão para sortear um nome!';

  @override
  void initState() {
    super.initState();
    nomesDisponiveis = List.from(nomesOriginais);
  }

  void sortearNome() {
    if (nomesDisponiveis.isNotEmpty) {
      final random = Random();
      int indice = random.nextInt(nomesDisponiveis.length);
      String nomeSelecionado = nomesDisponiveis[indice];

      setState(() {
        mensagem = nomeSelecionado;
        historicoGanhadores.add(nomeSelecionado);
        nomesDisponiveis.removeAt(indice);
      });
      
      if (nomesDisponiveis.isEmpty) {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            mensagem = 'Todos foram sorteados! Reiniciando o jogo...';
          });
          Future.delayed(const Duration(seconds: 2), () {
            resetarJogo();
          });
        });
      }
    }
  }
  
  void resetarJogo() {
    setState(() {
      nomesDisponiveis = List.from(nomesOriginais);
      historicoGanhadores.clear();
      mensagem = 'Clique no botão para sortear um nome!';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorteador com Histórico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                mensagem,
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: sortearNome,
              child: const Text('Sortear Nome'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Histórico de Ganhadores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: historicoGanhadores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(historicoGanhadores[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}