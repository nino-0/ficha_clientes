import 'package:firebase_auth/firebase_auth.dart';
import 'package:sheets_clients/services/auth_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> Login(String email, String pass) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      return "logou";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw AuthException(message: "Usuario não encontrado!");
      } else if (e.code == "wrong-password") {
        throw AuthException(message: "E-mail ou senha incorreto");
      }
      return e.message!;
    }
  }

  Future<String> register(String email, String pass) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      return "registou";
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw AuthException(message: "Usuario não encontrado!");
      } else if (e.code == "wrong-password") {
        throw AuthException(message: "E-mail ou senha incorreto");
      }
      return e.message!;
    }
  }
}
