import 'package:flutter/material.dart';
import 'package:nike_2/data/repo/auth_repository.dart';
import 'package:nike_2/theme.dart';
import 'package:nike_2/ui/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = TextStyle(
        fontFamily: 'iranYekan', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: defaultTextStyle.copyWith(
              color: LightThemeColors.secondaryTextColor,
              fontWeight: FontWeight.normal),
          floatingLabelStyle:
              defaultTextStyle.copyWith(color: LightThemeColors.primaryColor),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LightThemeColors.primaryColor)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: LightThemeColors.secondaryTextColor, width: 1),
          ),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            titleTextStyle: defaultTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold)),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: defaultTextStyle.color,
            contentTextStyle: defaultTextStyle.copyWith(color: Colors.white)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(defaultTextStyle))),
        textTheme: TextTheme(
          bodyLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
          bodyMedium: defaultTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
          bodySmall: defaultTextStyle.copyWith(
              color: LightThemeColors.secondaryTextColor),
          titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
          labelLarge: defaultTextStyle,
          titleMedium: defaultTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 16)
        ),
        colorScheme: ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
          surface: Colors.white,
          surfaceContainer: LightThemeColors.secondaryTextColor,
        ),
        useMaterial3: true,
      ),
      home: Directionality(
          textDirection: TextDirection.rtl, child: const RootScreen()),
    );
  }
}
