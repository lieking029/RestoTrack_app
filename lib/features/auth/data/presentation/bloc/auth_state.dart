import 'package:equatable/equatable.dart';
import 'package:restotrack_app/features/auth/data/models/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {

  AuthAuthenticated(this.user);
  final UserModel user;

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {

  AuthError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
