import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_2/data/repo/auth_repository.dart';
import 'package:nike_2/data/repo/cart_repository.dart';
import 'package:nike_2/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController =
      TextEditingController(text: 'test@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const Color onBackground = Colors.white;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
          snackBarTheme:
              SnackBarThemeData(backgroundColor: themeData.colorScheme.primary),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(
                Size.fromHeight(56),
              ),
              backgroundColor: WidgetStatePropertyAll(onBackground),
              foregroundColor:
                  WidgetStatePropertyAll(themeData.colorScheme.secondary),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            errorStyle: TextStyle(color: onBackground),
            labelStyle:
                TextStyle(color: onBackground, fontWeight: FontWeight.normal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: onBackground),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: onBackground,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: BlocProvider<AuthBloc>(
          create: (context) {
            final bloc = AuthBloc(
                authRepository: authRepository, cartRepository: cartRepository);
            bloc.stream.forEach((state) {
              if (state is AuthSuccess) {
                Navigator.of(context).pop();
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.exception.message),
                  ),
                );
              }
            });
            bloc.add(AuthStarted());
            return bloc;
          },
          child: Scaffold(
            backgroundColor: themeData.colorScheme.secondary,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) =>
                    current is AuthInitial ||
                    current is AuthLoading ||
                    current is AuthError,
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/nike-white.png',
                        width: 90,
                        height: 90,
                      ),
                      Text(
                        'خوش آمدید',
                        style: TextStyle(color: onBackground, fontSize: 18),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        state.isLoginMode
                            ? 'اطلاعات حساب خود را وارد کنید'
                            : 'لطفا یک حساب کابری ایجاد کنید',
                        style: TextStyle(color: onBackground, fontSize: 16),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextField(
                        controller: usernameController,
                        style: TextStyle(
                            color: onBackground, fontWeight: FontWeight.normal),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text('ایمیل'),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _PasswordTextField(
                        onBackground: onBackground,
                        passwordController: passwordController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthButtonClicked(usernameController.text,
                                passwordController.text),
                          );
                        },
                        child: state is AuthLoading
                            ? CupertinoActivityIndicator()
                            : Text(state.isLoginMode ? 'ورود' : 'ثبت نام'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.isLoginMode
                                ? 'حساب کاربری ندارید؟'
                                : 'حساب کاربری دارید؟',
                            style: TextStyle(color: onBackground),
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(AuthModeButtonClicked());
                            },
                            child: Text(state.isLoginMode ? 'ثبت نام' : 'ورود'),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.onBackground,
    required this.passwordController,
  });

  final Color onBackground;
  final TextEditingController passwordController;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordController,
      style: TextStyle(
        color: widget.onBackground,
        fontWeight: FontWeight.normal,
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text('رمز عبور'),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            color: widget.onBackground,
          ),
        ),
      ),
    );
  }
}
