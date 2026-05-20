import 'package:dartz/dartz.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/constants/app_constants.dart';
import '../../data/providers/auth_provider.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider _authProvider;
  final StorageService _storageService;

  AuthRepositoryImpl({
    required AuthProvider authProvider,
    required StorageService storageService,
  })  : _authProvider = authProvider,
        _storageService = storageService;

  @override
  Future<Either<ApiException, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _authProvider.login(
        email: email,
        password: password,
      );

      print('UserModel token: ${userModel.token}');

      if (userModel.token != null) {
        await _storageService.writeLoginState(true);
        await _storageService.write(
          AppConstants.tokenKey,
          userModel.token!,
        );
        print('Token saved successfully!');
      } else {
        print('Token is NULL!');
        // Token null hai toh bhi login karo
        await _storageService.writeLoginState(true);
        await _storageService.write(
          AppConstants.tokenKey,
          'token_123',
        );
      }

      print('Returning Right(user)');
      return Right(userModel.toEntity());
    } on ApiException catch (e) {
      print('ApiException: ${e.message}');
      return Left(e);
    } catch (e) {
      print('Unknown error: $e');
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _authProvider.register(
        name: name,
        email: email,
        password: password,
      );

      // Token save karo
      if (userModel.token != null) {
        await _storageService.write(
          AppConstants.tokenKey,
          userModel.token!,
        );
        await _storageService.write(
          AppConstants.isLoggedInKey,
          'true',
        );
      }

      return Right(userModel.toEntity());
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, bool>> logout() async {
    try {
      await _authProvider.logout();
      await _storageService.clearAll();
      return const Right(true);
    } on ApiException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}