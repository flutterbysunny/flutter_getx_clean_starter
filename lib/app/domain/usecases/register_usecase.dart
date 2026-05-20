import 'package:dartz/dartz.dart';
import '../../../core/network/api_exception.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import 'base_usecase.dart';

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

class RegisterUseCase extends BaseUseCase<UserEntity, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<Either<ApiException, UserEntity>> call(RegisterParams params) {
    return _authRepository.register(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}