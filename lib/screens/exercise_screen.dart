import 'package:flutter/material.dart';
import 'package:flutter_gymapp/models/exercise_model.dart';
import 'package:flutter_gymapp/models/feeling_model.dart';

class ExerciseScreen extends StatelessWidget {
  ExerciseScreen({super.key});
  final ExerciseModel exerciseModel = ExerciseModel(
    id: "01",
    name: "Remada Baixa Supinada",
    training: "Treino A",
    howToDoIt: "Segura a barra e puxa",
  );
  final List<FeelingModel> listFeeling = [
    FeelingModel(id: "01", feeling: "Pouca ativação hoje", date: "2025-06-01"),
    FeelingModel(id: "02", feeling: "Ganhei mais força", date: "2025-06-03"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              exerciseModel.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            Text(
              exerciseModel.training,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0A6D92),
        elevation: 0,
        toolbarHeight: 72,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.vertical(
            bottom: Radius.circular(32),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("FOI CLICADO!");
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: Text(
                      "Enviar foto",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Tirar foto"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Como fazer?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(exerciseModel.howToDoIt),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Divider(color: Colors.black),
            ),
            const SizedBox(height: 8),
            const Text(
              "Como estou me sentindo?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(listFeeling.length, (index) {
                FeelingModel feelinNow = listFeeling[index];
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(feelinNow.feeling),
                  subtitle: Text(feelinNow.date),
                  leading: const Icon(Icons.double_arrow),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      print("Deletar ${feelinNow.feeling}");
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
