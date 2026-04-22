import 'package:client/core/network/dio_client.dart';
import 'package:client/core/styles/themes.dart';
import 'package:client/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:client/features/auth/domain/repositories/auth_repository.dart';
import 'package:client/features/auth/domain/usecases/login_usecase.dart';
import 'package:client/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:client/features/login/presentation/pages/login_page.dart';
import 'package:client/features/home/presentation/pages/home_page.dart';
import 'package:client/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dio = DioClient.create(
    enableLogging: true,
    baseUrl: 'http://localhost:8080/',
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  runApp(MainApp(dio: dio));
}

class MainApp extends StatelessWidget {
  final DioClient dio;
  const MainApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(dio: dio),
          dispose: (repository) => repository.dispose(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              loginUseCase: LoginUseCase(
                authRepository: context.read<AuthRepository>(),
              ),
            )..add(AuthSubscriptionRequested()),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                _navigator.pushAndRemoveUntil(HomePage.route(), (_) => false);
                break;
              case AuthStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(LoginPage.route(), (_) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
