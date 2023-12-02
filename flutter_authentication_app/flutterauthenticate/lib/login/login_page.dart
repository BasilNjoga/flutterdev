import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterauthenticate/bloc/authentication_bloc.dart';
import 'package:flutterauthenticate/login/bloc/login_bloc.dart';
import 'package:flutterauthenticate/login/login_form.dart';
import 'package:flutterauthenticate/repository/user_repository.dart';


class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({Key ?key, required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login | Home Hub'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: const LoginForm(),
      ),
    );
  }
}