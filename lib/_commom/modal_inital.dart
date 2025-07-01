import 'package:flutter/material.dart';
import 'package:flutter_gymapp/_commom/my_colors.dart';
import 'package:flutter_gymapp/components/authentication_input_decoration.dart';
import 'package:flutter_gymapp/models/exercise_model.dart';
import 'package:flutter_gymapp/models/feeling_model.dart';
import 'package:flutter_gymapp/services/exercise_service.dart';
import 'package:uuid/uuid.dart';

ShowModalInitial(BuildContext context, {ExerciseModel? exercise}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: MyColors.azulEscuro,
    isDismissible: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (context) {
      return ExerciseModal(exerciseModel: exercise);
    },
  );
}

class ExerciseModal extends StatefulWidget {
  final ExerciseModel? exerciseModel;
  const ExerciseModal({super.key, this.exerciseModel});

  @override
  State<ExerciseModal> createState() => _ExerciseModalState();
}

class _ExerciseModalState extends State<ExerciseModal> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _trainingController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _feelingController = TextEditingController();

  ExerciseService _exerciseService = ExerciseService();

  @override
  void initState() {
    if (widget.exerciseModel != null) {
      _nameController.text = widget.exerciseModel!.name;
      _trainingController.text = widget.exerciseModel!.training;
      _notesController.text = widget.exerciseModel!.howToDoIt;
    }
    super.initState();
  }

  bool isLoading = false;
  sendClick() {
    setState(() {
      isLoading = true;
      String name = _nameController.text;
      String training = _trainingController.text;
      String notes = _notesController.text;
      String feeling = _feelingController.text;

      ExerciseModel exerciseModel = ExerciseModel(
        id: const Uuid().v1(),
        name: name,
        training: training,
        howToDoIt: notes,
      );
      if (widget.exerciseModel != null) {
        exerciseModel.id = widget.exerciseModel!.id;
      }
      _exerciseService.addExercise(exerciseModel).then((value) {
        if (feeling != "") {
          FeelingModel feelingModel = FeelingModel(
            id: Uuid().v1(),
            feeling: feeling,
            date: DateTime.now().toString(),
          );
          _exerciseService.addFeeling(exerciseModel.id, feelingModel);
          setState(() {
            isLoading = false;
            Navigator.pop(context);
          });
        } else {
          setState(() {
            isLoading = false;
            Navigator.pop(context);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        (widget.exerciseModel != null)
                            ? "Editar ${widget.exerciseModel!.name}"
                            : "Adicionar Exercício",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
                const Divider(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: getAuthenticationInputDecoration(
                        "Qual o nome do exercício?",
                        icon: Icon(Icons.abc, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _trainingController,
                      decoration: getAuthenticationInputDecoration(
                        "Qual treino pertence?",
                        icon: Icon(Icons.list_alt_rounded, color: Colors.white),
                      ),
                    ),
                    Text(
                      "Use o mesmo nome para exercícios que pertencem ao mesmo treino",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      decoration: getAuthenticationInputDecoration(
                        "Quais anotações você tem?",
                        icon: Icon(Icons.notes_rounded, color: Colors.white),
                      ),
                      maxLines: null,
                    ),
                    Visibility(
                      visible: (widget.exerciseModel == null),
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _feelingController,
                            decoration: getAuthenticationInputDecoration(
                              "Como você está se sentindo?",
                              icon: Icon(
                                Icons.emoji_emotions_rounded,
                                color: Colors.white,
                              ),
                            ),
                            maxLines: null,
                          ),
                          Text(
                            "Opcional",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                sendClick();
              },
              child: (isLoading)
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: MyColors.azulEscuro,
                      ),
                    )
                  : Text(
                      (widget.exerciseModel != null)
                          ? "Editar exercício"
                          : "Criar Exercício",
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
