import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/features/auth/domain/entity/app_user.dart';
import 'package:news/features/auth/domain/repository/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepository firebaseAuthRepository;
  StreamSubscription<User?>? _userAuthSubscription;
  StreamSubscription<AppUserEntity?>? _userDataSubscription;
  AuthBloc(this.firebaseAuthRepository) : super(AuthInitial()) {
    _userAuthSubscription = FirebaseAuth.instance.authStateChanges().listen((
      user,
    ) {
      add(AuthUserChanged(user: user));
    });

    on<AuthUserChanged>(_authUserChanged);

    on<AuthDataUpdated>(_authDataUpdated);

    on<LoginFirebase>(_loginFirebase);

    on<RegisterFirebase>(_registerFirebase);

    on<ResetPassword>(_resetPassword);

    on<Logout>(_logout);

    on<UpdateUserData>(_updateUserData);

    on<UpdateUserAvatar>(_updateUserAvatar);
  }

  // void _updateUserAvatar(event, emit) {
  //   final currentState = state;
  //   if (currentState is AuthAuthenticated && currentState.appUser != null) {
  //     final updatedUser = currentState.appUser!.copyWith(
  //       avatarUrl: event.avatarUrl,
  //     );
  //     emit(currentState.copyWith(appUser: updatedUser));
  //   }
  // }
  // Future<void> _updateUserAvatar(event, emit) async {
  //   emit(UpdateUserDataLoading());
  //   try {
  //     await firebaseAuthRepository.uploadAndSaveAvatar(
  //       imageFile: event.avatarUrl,
  //     );
  //   } catch (e) {
  //     emit(UpdateUserDataError(error: e.toString()));
  //   }
  // }
  Future<void> _updateUserAvatar(
    UpdateUserAvatar event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is! AuthAuthenticated) return;

    emit(UpdateUserDataLoading());
    try {
      final downloadUrl = await firebaseAuthRepository.uploadAndSaveAvatar(
        imageFile: event.imageFile,
      );

      if (currentState.appUser != null) {
        final updatedUser = currentState.appUser!.copyWith(
          avatarUrl: downloadUrl,
        );
        emit(currentState.copyWith(appUser: updatedUser));
      }
    } catch (e) {
      emit(UpdateUserDataError(error: e.toString()));
    }
  }

  Future<void> _updateUserData(event, emit) async {
    emit(UpdateUserDataLoading());
    try {
      await firebaseAuthRepository.updateUserData(event.data);
    } catch (e) {
      emit(UpdateUserDataError(error: e.toString()));
    }
  }

  FutureOr<void> _logout(event, emit) async {
    await FirebaseAuth.instance.signOut();
    emit(AuthUnauthenticated());
  }

  FutureOr<void> _resetPassword(event, emit) async {
    emit(PasswordResetLoading());
    try {
      await firebaseAuthRepository.sendPasswordResetEmail(event.email);
      emit(PasswordResetSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Произошла неизвестная ошибка.';
      if (e.code == 'user-not-found') {
        errorMessage = 'Пользователь с таким email не найден.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Неверный формат email адреса.';
      }
      emit(PasswordResetFailure(error: errorMessage));
    } catch (e) {
      emit(PasswordResetFailure(error: e.toString()));
    }
  }

  FutureOr<void> _registerFirebase(event, emit) async {
    emit(RegisterFirebaseLoading());
    try {
      final user = await firebaseAuthRepository.registerWithEmailAndPassword(
        email: event.email,
        password: event.password,
        username: event.username,
        phoneNumber: event.phoneNumber,
      );
      if (user == null) {
        emit(RegisterFirebaseFailure(error: 'Не удалось зарегестрироваться'));
      }
    } catch (e) {
      emit(RegisterFirebaseFailure(error: e.toString()));
    }
  }

  FutureOr<void> _loginFirebase(event, emit) async {
    emit(LoginFirebaseLoading());
    try {
      final user = await firebaseAuthRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      if (user == null) {
        emit(LoginFirebaseFailure(error: 'Не удалось войти'));
      }
    } catch (e) {
      emit(LoginFirebaseFailure(error: e.toString()));
    }
  }

  FutureOr<void> _authDataUpdated(event, emit) {
    emit(AuthAuthenticated(user: event.user, appUser: event.appUser));
  }

  FutureOr<void> _authUserChanged(event, emit) async {
    _userDataSubscription?.cancel();
    if (event.user != null) {
      _userDataSubscription = firebaseAuthRepository
          .watchUserData(event.user!.uid)
          .listen((appUser) {
            add(AuthDataUpdated(user: event.user!, appUser: appUser));
          });
    } else {
      emit(AuthUnauthenticated());
    }
  }

  @override
  Future<void> close() {
    _userAuthSubscription?.cancel();
    _userDataSubscription?.cancel();
    return super.close();
  }
}
