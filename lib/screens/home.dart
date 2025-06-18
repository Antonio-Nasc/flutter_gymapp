import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gymapp/models/exercise_model.dart';
import 'package:flutter_gymapp/screens/exercise_screen.dart';
import 'package:flutter_gymapp/services/authentication_service.dart';

class Home extends StatefulWidget {
  final User user;
  Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ExerciseModel> listExercices = [
    ExerciseModel(
      id: "1",
      name: "Puxada Alta Pronada",
      training: "Treino A",
      howToDoIt: "Puxada",
    ),
    ExerciseModel(
      id: "2",
      name: "Remad Supinada",
      training: "Treino B",
      howToDoIt: "Puxada",
    ),
    ExerciseModel(
      id: "1",
      name: "Puxada Alta Pronada",
      training: "Treino A",
      howToDoIt: "Puxada",
    ),
    ExerciseModel(
      id: "2",
      name: "Remad Supinada",
      training: "Treino B",
      howToDoIt: "Puxada",
    ),
    ExerciseModel(
      id: "1",
      name: "Puxada Alta Pronada",
      training: "Treino A",
      howToDoIt: "Puxada",
    ),
    ExerciseModel(
      id: "2",
      name: "Remad Supinada",
      training: "Treino B",
      howToDoIt: "Puxada",
    ),
    ExerciseModel(
      id: "1",
      name: "Puxada Alta Pronada",
      training: "Treino A",
      howToDoIt: "Puxada",
    ),
    ExerciseModel(
      id: "2",
      name: "Remad Supinada",
      training: "Treino B",
      howToDoIt: "Puxada",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus exercícios")),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/logo.png"),
              ),
              accountName: Text(
                (widget.user.displayName != null)
                    ? widget.user.displayName!
                    : "",
              ),
              accountEmail: Text(widget.user.email!),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sair"),
              dense: true,
              onTap: () {
                AuthenticationService().logout();
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: List.generate(listExercices.length, (index) {
          ExerciseModel exerciseModel = listExercices[index];
          return ListTile(
            title: Text(exerciseModel.name),
            subtitle: Text(exerciseModel.training),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ExerciseScreen(exerciseModel: exerciseModel),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
