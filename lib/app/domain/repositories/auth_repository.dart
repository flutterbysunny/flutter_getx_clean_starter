import 'package:dartz/dartz.dart';
import '../../../core/network/api_exception.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<ApiException, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<ApiException, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<ApiException, bool>> logout();
}