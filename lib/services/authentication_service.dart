import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  registerUser({
    required String nome,
    required String senha,
    required String email,
  }) {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
  }
}
