part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  final AppUserEntity? appUser;

  AuthAuthenticated({required this.user, this.appUser});

  AuthAuthenticated copyWith({User? user, AppUserEntity? appUser}) {
    return AuthAuthenticated(
      user: user ?? this.user,
      appUser: appUser ?? this.appUser,
    );
  }

  @override
  List<Object?> get props => [user, appUser];
}

class AuthUnauthenticated extends AuthState {}

class LoginFirebaseLoading extends AuthState {}

class LoginFirebaseFailure extends AuthState {
  final String error;
  LoginFirebaseFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class RegisterFirebaseLoading extends AuthState {}

class RegisterFirebaseFailure extends AuthState {
  final String error;
  RegisterFirebaseFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdateUserDataLoading extends AuthState {}

class UpdateUserDataError extends AuthState {
  final String error;
  UpdateUserDataError({required this.error});

  @override
  List<Object?> get props => [error];
}

class PasswordResetLoading extends AuthState {}

class PasswordResetSuccess extends AuthState {}

class PasswordResetFailure extends AuthState {
  final String error;
  PasswordResetFailure({required this.error});

  @override
  List<Object> get props => [error];
}
