import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gymapp/models/exercise_model.dart';
import 'package:flutter_gymapp/models/feeling_model.dart';

class ExerciseService {
  String userId;
  ExerciseService() : userId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addExercise(ExerciseModel exerciseModel) async {
    return await _firestore
        .collection(userId)
        .doc(exerciseModel.id)
        .set(exerciseModel.toMap());
  }

  Future<void> addFeeling(String idExercise, FeelingModel feelingModel) async {
    return await _firestore
        .collection(userId)
        .doc(idExercise)
        .collection('feelings')
        .doc(feelingModel.id)
        .set(feelingModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectStreamExercise(
    bool isDescending,
  ) {
    return _firestore
        .collection(userId)
        .orderBy("training", descending: isDescending)
        .snapshots();
  }

  Future<void> removeExercise({required String idExercise}) {
    return _firestore.collection(userId).doc(idExercise).delete();
  }
}
