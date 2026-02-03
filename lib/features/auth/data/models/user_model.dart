import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {

  const factory UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? middleName,
    @Default(2) int userType,
    @Default([]) List<RoleModel> roles,
  }) = _UserModel;
  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  String get fullName {
    if (middleName != null && middleName!.isNotEmpty) {
      return '$firstName $middleName $lastName';
    }
    return '$firstName $lastName';
  }

  List<String> get roleNames => roles.map((r) => r.name).toList();
  String get primaryRole => roles.isNotEmpty ? roles.first.name : 'employee';

  bool get isAdmin => userType == 0;
  bool get isManager => userType == 1;
  bool get isEmployee => userType == 2;

  bool hasRole(String role) => roleNames.contains(role);
  bool get isServer => hasRole('server');
  bool get isBarista => hasRole('barista');
  bool get isCashier => hasRole('cashier');
  bool get isCook => hasRole('cook');
  bool get isChef => hasRole('chef');
  bool get isKitchenStaff => isCook || isChef;
  bool get isOrderTaker => isServer || isBarista;
}

@freezed
class RoleModel with _$RoleModel {
  const factory RoleModel({
    required String name,
  }) = _RoleModel;

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);
}