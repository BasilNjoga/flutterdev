import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterauthenticate/login/bloc/login_bloc.dart';
import 'dart:developer' as devtools;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          devtools.log("login failed here");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'username', icon: Icon(Icons.person)),
                    controller: _emailController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'password', icon: Icon(Icons.security)),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.width * 0.22,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        onPressed: () {
                          devtools.log(_emailController.text);
                          onLoginButtonPressed(); },
                        style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: state is LoginLoading
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
