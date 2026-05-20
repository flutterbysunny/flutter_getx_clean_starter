import 'package:dartz/dartz.dart';
import '../../../core/network/api_exception.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class LoginUseCase extends BaseUseCase<UserEntity, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Either<ApiException, UserEntity>> call(LoginParams params) {
    return _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}