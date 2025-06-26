import 'package:flutter/material.dart';
import 'package:flutter_gymapp/_commom/my_colors.dart';
import 'package:flutter_gymapp/components/authentication_input_decoration.dart';

ShowModalInitial(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: MyColors.azulEscuro,
    isDismissible: false,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (context) {
      return const ExerciseModal();
    },
  );
}

class ExerciseModal extends StatefulWidget {
  const ExerciseModal({super.key});

  @override
  State<ExerciseModal> createState() => _ExerciseModalState();
}

class _ExerciseModalState extends State<ExerciseModal> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _trainingController = TextEditingController();
  TextEditingController _notesController = TextEditingController();
  TextEditingController _feelingController = TextEditingController();

  bool isLoading = false;

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
                    const Text(
                      "Adicionar Exercício",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      decoration: getAuthenticationInputDecoration(
                        "Quais anotações você tem?",
                        icon: Icon(Icons.notes_rounded, color: Colors.white),
                      ),
                      maxLines: null,
                    ),
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
                  ],
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {},
              child: (isLoading)
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: MyColors.azulEscuro,
                      ),
                    )
                  : Text("Criar Exercício"),
            ),
          ],
        ),
      ),
    );
  }
}
