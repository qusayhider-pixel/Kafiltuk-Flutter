import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword),
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email);
  }

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.initial, clearErrors: true));

    String? emailError;
    String? passwordError;

    if (email.trim().isEmpty) {
      emailError = 'Email is required';
    } else if (!_isValidEmail(email.trim())) {
      emailError = 'Enter a valid email address';
    }

    if (password.isEmpty) {
      passwordError = 'Password is required';
    } else if (password.length < 6) {
      passwordError = 'Password must be at least 6 characters';
    }

    if (emailError != null || passwordError != null) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          emailError: emailError,
          passwordError: passwordError,
        ),
      );
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(milliseconds: 1400));
    emit(state.copyWith(status: AuthStatus.success));
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: AuthStatus.initial, clearErrors: true));

    String? nameError;
    String? emailError;
    String? passwordError;
    String? confirmPasswordError;

    if (name.trim().isEmpty) {
      nameError = 'Full name is required';
    }

    if (email.trim().isEmpty) {
      emailError = 'Email is required';
    } else if (!_isValidEmail(email.trim())) {
      emailError = 'Enter a valid email address';
    }

    if (password.isEmpty) {
      passwordError = 'Password is required';
    } else if (password.length < 6) {
      passwordError = 'Password must be at least 6 characters';
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordError = 'Please confirm your password';
    } else if (confirmPassword != password) {
      confirmPasswordError = 'Passwords do not match';
    }

    if (nameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          nameError: nameError,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
        ),
      );
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));
    await Future.delayed(const Duration(milliseconds: 1400));
    emit(state.copyWith(status: AuthStatus.success));
  }
}