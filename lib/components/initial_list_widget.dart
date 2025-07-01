import 'package:flutter/material.dart';
import 'package:flutter_gymapp/_commom/modal_inital.dart';
import 'package:flutter_gymapp/_commom/my_colors.dart';
import 'package:flutter_gymapp/models/exercise_model.dart';
import 'package:flutter_gymapp/screens/exercise_screen.dart';
import 'package:flutter_gymapp/services/exercise_service.dart';

class InitialItemList extends StatelessWidget {
  final ExerciseModel exerciseModel;
  final ExerciseService service;
  const InitialItemList({
    super.key,
    required this.exerciseModel,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseScreen(exerciseModel: exerciseModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withAlpha(125),
              spreadRadius: 1,
              offset: const Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
        height: 100,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.azulEscuro,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                width: 150,
                height: 30,
                child: Text(
                  exerciseModel.training,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          exerciseModel.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: MyColors.azulEscuro,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              ShowModalInitial(
                                context,
                                exercise: exerciseModel,
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              SnackBar snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Deseja remover ${exerciseModel.name}?",
                                ),
                                action: SnackBarAction(
                                  label: "REMOVER",
                                  textColor: Colors.white,
                                  onPressed: () {
                                    service.removeExercise(
                                      idExercise: exerciseModel.id,
                                    );
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            },
                            icon: Icon(Icons.remove, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          exerciseModel.howToDoIt,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
