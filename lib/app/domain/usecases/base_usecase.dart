import 'package:dartz/dartz.dart';
import '../../../core/network/api_exception.dart';

abstract class BaseUseCase<Output, Params> {
  Future<Either<ApiException, Output>> call(Params params);
}

// Jab koi params na ho
class NoParams {}