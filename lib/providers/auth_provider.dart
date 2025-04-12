import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user_model.dart';
import '../services/auth/auth_service.dart';
import '../services/auth/firebase_auth_service.dart';

part 'auth_provider.g.dart';

/// Provider for the AuthService
@riverpod
AuthService authenticationService(Ref ref) {
  return FirebaseAuthService();
}

/// Provider for the current Firebase User
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  final authService = ref.watch(authenticationServiceProvider);
  return authService.authStateChanges;
}

/// Provider for the current UserModel
@riverpod
Future<UserModel?> currentUser(CurrentUserRef ref) async {
  final authState = await ref.watch(authStateChangesProvider.future);
  if (authState == null) {
    return null;
  }
  return UserModel.fromFirebaseUser(authState);
}

/// Provider to check if a user is authenticated
@riverpod
Future<bool> isAuthenticated(IsAuthenticatedRef ref) async {
  final user = await ref.watch(currentUserProvider.future);
  return user != null;
}
