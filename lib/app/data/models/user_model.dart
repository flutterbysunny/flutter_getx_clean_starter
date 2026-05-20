import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.token,
  });

  // JSON → Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',      // ← toString() already hai ✅
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      avatar: json['avatar']?.toString(),
      token: json['token']?.toString(),
    );
  }

  // Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'token': token,
    };
  }

  // Model → Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      token: token,
    );
  }

  // Entity → Model
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      avatar: entity.avatar,
      token: entity.token,
    );
  }

  @override
  List<Object?> get props => [id, name, email, avatar, token];
}