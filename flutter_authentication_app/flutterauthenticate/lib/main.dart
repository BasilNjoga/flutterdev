import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterauthenticate/bloc/authentication_bloc.dart';
import 'package:flutterauthenticate/common/loading_indicator.dart';
import 'package:flutterauthenticate/home/home_page.dart';
import 'package:flutterauthenticate/login/login_page.dart';
import 'package:flutterauthenticate/repository/user_repository.dart';
import 'package:flutterauthenticate/splash/splash_page.dart';

import 'dart:developer' as devtools;


void main() {
  final userRepository = UserRepository();

  runApp(
      BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(
              userRepository: userRepository
          )..add(AppStarted());
        },
        child: App(userRepository: userRepository),
      )
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({Key ?key, required this.userRepository})
      : super(key: key);

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            devtools.log("not initialised authentication");
            return const SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            devtools.log("has been authenticated");
            return const HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            devtools.log("not authenticated");
            return LoginPage(userRepository: userRepository,);
          }
          return const LoadingIndicator();
        },
      ),
    );
  }
}
