import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    await credential.user?.updateDisplayName(fullName.trim());
    await credential.user?.reload();

    return credential;
  }

  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return credential;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}