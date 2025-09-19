part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final User? user;
  AuthUserChanged({this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserData extends AuthEvent {
  final Map<String, dynamic> data;

  UpdateUserData(this.data);

  @override
  List<Object> get props => [data];
}

class AuthDataUpdated extends AuthEvent {
  final User user;
  final AppUserEntity? appUser;
  AuthDataUpdated({required this.user, this.appUser});

  @override
  List<Object?> get props => [user, appUser];
}

class LoginFirebase extends AuthEvent {
  final String email;
  final String password;

  LoginFirebase({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UpdateUserAvatar extends AuthEvent {
  final File imageFile;

  UpdateUserAvatar(this.imageFile);

  @override
  List<Object> get props => [imageFile];
}

class RegisterFirebase extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String phoneNumber;

  RegisterFirebase({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [email, password, username];
}

class ResetPassword extends AuthEvent {
  final String email;

  ResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}

class Logout extends AuthEvent {}
