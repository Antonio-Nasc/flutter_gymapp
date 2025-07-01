import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gymapp/_commom/modal_inital.dart';
import 'package:flutter_gymapp/_commom/my_colors.dart';
import 'package:flutter_gymapp/components/initial_list_widget.dart';
import 'package:flutter_gymapp/models/exercise_model.dart';
import 'package:flutter_gymapp/services/authentication_service.dart';
import 'package:flutter_gymapp/services/exercise_service.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ExerciseService service = ExerciseService();
  bool isDescending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Meus exercícios"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDescending = !isDescending;
              });
            },
            icon: Icon(Icons.sort_by_alpha_rounded),
          ),
        ],
      ),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ShowModalInitial(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder(
          stream: service.conectStreamExercise(isDescending),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.docs.isNotEmpty) {
                List<ExerciseModel> listExercise = [];
                for (var doc in snapshot.data!.docs) {
                  listExercise.add(ExerciseModel.fromMap(doc.data()));
                }
                return ListView(
                  children: List.generate(listExercise.length, (index) {
                    ExerciseModel exerciseModel = listExercise[index];
                    return InitialItemList(
                      exerciseModel: exerciseModel,
                      service: service,
                    );
                  }),
                );
              } else {
                return const Center(child: Text("Ainda nenhum exercício."));
              }
            }
          },
        ),
      ),
    );
  }
}
