import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_2/common/exception.dart';
import 'package:nike_2/data/repo/auth_repository.dart';
import 'package:nike_2/data/repo/cart_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginMode;
  final CartRepository cartRepository;
  final IAuthRepository authRepository;
  AuthBloc(
      {required this.authRepository,
      required this.cartRepository,
      this.isLoginMode = true})
      : super(AuthInitial(isLoginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonClicked) {
          emit(AuthLoading(isLoginMode));
          if (isLoginMode) {
            await authRepository.login(event.username, event.password);
            await cartRepository.count();
            emit(AuthSuccess(isLoginMode));
          } else {
            await authRepository.register(event.username, event.password);
            emit(AuthSuccess(isLoginMode));
          }
        } else if (event is AuthModeButtonClicked) {
          isLoginMode = !isLoginMode;
          emit(AuthInitial(isLoginMode));
        }
      } catch (e) {
        emit(
          AuthError(
            isLoginMode,
            exception: AppException(),
          ),
        );
      }
    });
  }
}
