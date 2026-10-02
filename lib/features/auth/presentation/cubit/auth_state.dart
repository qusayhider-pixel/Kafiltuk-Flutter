part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.errorMessage,
  });

  bool get isLoading => status == AuthStatus.loading;

  AuthState copyWith({
    AuthStatus? status,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? errorMessage,
    bool clearErrors = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      nameError: clearErrors ? null : (nameError ?? this.nameError),
      emailError: clearErrors ? null : (emailError ?? this.emailError),
      passwordError:
          clearErrors ? null : (passwordError ?? this.passwordError),
      confirmPasswordError: clearErrors
          ? null
          : (confirmPasswordError ?? this.confirmPasswordError),
      errorMessage: clearErrors ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        obscurePassword,
        obscureConfirmPassword,
        nameError,
        emailError,
        passwordError,
        confirmPasswordError,
        errorMessage,
      ];
}