import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../services/auth/auth_service.dart';

/// Authentication view model following MVVM pattern
class AuthenticationViewModel extends ChangeNotifier {
  final AuthService _authService;
  UserModel? _currentUser;
  String? _errorMessage;
  bool _isLoading = false;

  /// Constructor that takes an AuthService
  AuthenticationViewModel(this._authService) {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      if (user != null) {
        _currentUser = UserModel.fromFirebaseUser(user);
      } else {
        _currentUser = null;
      }
      notifyListeners();
    });
  }

  /// Current user
  UserModel? get currentUser => _currentUser;

  /// Error message
  String? get errorMessage => _errorMessage;

  /// Loading state
  bool get isLoading => _isLoading;

  /// Check if user is authenticated
  bool get isAuthenticated => _currentUser != null;

  /// Sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Create a new user with email and password
  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.createUserWithEmailAndPassword(email, password);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.signInWithGoogle();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.signInWithApple();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.signOut();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    _clearError();
    try {
      await _authService.sendPasswordResetEmail(email);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Set error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clear error message
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

/// Provider for the AuthenticationViewModel
final authViewModelProvider = ChangeNotifierProvider<AuthenticationViewModel>(
  (ref) => AuthenticationViewModel(ref.watch(authenticationServiceProvider)),
);
