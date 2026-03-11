import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login
  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "done";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return "No user found for that email.";
        case 'wrong-password':
          return "Wrong password provided for that user.";
        case 'invalid-email':
          return "Invalid email address.";
        case 'user-disabled':
          return "This user account has been disabled.";
        default:
          return e.message ?? "Something went wrong.";
      }
    } catch (_) {
      return "Something went wrong.";
    }
  }

  // Register
  Future<String> register(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user?.uid;
      if (uid == null) return "Something went wrong creating the user.";

      await _firestore.collection("USERS").doc(uid).set({
        "email": email,
        "id": uid,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return "done";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return "The password provided is too weak.";
        case 'email-already-in-use':
          return "The account already exists for that email.";
        case 'invalid-email':
          return "Invalid email address.";
        default:
          return e.message ?? "Something went wrong.";
      }
    } catch (_) {
      return "Something went wrong.";
    }
  }

  // Logout
  Future<void> logout() => _auth.signOut();
}