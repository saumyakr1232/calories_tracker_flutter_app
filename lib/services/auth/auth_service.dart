import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class for authentication services
/// This allows for easy swapping of authentication providers
abstract class AuthService {
  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;

  /// Returns the current user
  User? get currentUser;

  /// Signs in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password);

  /// Creates a new user with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password);

  /// Signs in with Google
  Future<UserCredential> signInWithGoogle();

  /// Signs in with Apple
  Future<UserCredential> signInWithApple();

  /// Signs out the current user
  Future<void> signOut();

  /// Sends password reset email
  Future<void> sendPasswordResetEmail(String email);
}
