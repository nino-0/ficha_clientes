import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';

import 'package:sheets_clients/models/user_model.dart';

class AuthException implements Exception {
  String message;
  AuthException({
    required this.message,
  });
}

class AuthService {
  var isLoading = false.obs;

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    } else {
      return User(user.uid, user.email!);
    }
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

// Future<User?>
  Future<User?> Login(String email, String pass) async {
    isLoading.value = true;
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      isLoading.value = false;

      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == "user-not-found") {
        throw AuthException(message: "Usuario não encontrado!");
      } else if (e.code == "wrong-password") {
        throw AuthException(message: "E-mail ou senha incorreto");
      }
    }
  }

  Future<User?> register(String email, String pass) async {
    try {
      isLoading.value = true;
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      isLoading.value = false;

      return _userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == "weak-password") {
        throw AuthException(message: "A senha é muito fraca!");
      } else if (e.code == "email-already-in-use") {
        throw AuthException(message: "Este e-mail já esta em uso!");
      }
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
  // FirebaseAuth _auth = FirebaseAuth.instance;

  // Rxn<User> _firebaseUser = Rxn<User>();
}



  // @override
  // void onInit() {
  //   super.onInit();

  //   _firebaseUser.bindStream(_auth.authStateChanges());
  //   ever(_firebaseUser, User user) {
  //     if (user != null) {
  //       userIsAutheticated.value = true;
  //     } else {
  //       userIsAutheticated.value = false;
  //     }
  //   }
  // }

  // User? get user => _firebaseUser.value;

  // static AuthService get to => Get.find<AuthService>();

  // showSnack(String title, String err) {
  //   Get.snackbar(title, err,
  //       backgroundColor: Colors.grey,
  //       colorText: branco,
  //       snackPosition: SnackPosition.BOTTOM);
  // }

  // //Registar o usuario email e pass
  // createUser(String email, String password) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } catch (e) {
  //     showSnack("[Erro]- erro ao registar", 'erro ao criar user');
  //   }
  // }

  // //faz o login
  // login(String email, String password) async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } catch (e) {
  //     showSnack("[Erro]- no Login", 'erro ao fazer o login');
  //   }
  // }

  // //sair
  // logout() async {
  //   try {
  //     await _auth.signOut();
  //   } catch (e) {
  //     showSnack("[Erro]- erro ao sair", 'sair');
  //   }
  // }

