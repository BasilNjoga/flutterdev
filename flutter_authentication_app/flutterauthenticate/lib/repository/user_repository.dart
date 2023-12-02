import 'dart:async';

import 'package:flutterauthenticate/api_connection/api_connection.dart';
import 'package:flutterauthenticate/dao/user_dao.dart';
import 'package:flutterauthenticate/model/api_model.dart';
import 'package:flutterauthenticate/model/user_model.dart';
import 'dart:developer' as devtools;


class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate ({
    required String email,
    required String password,
  }) async {
    UserLogin userLogin = UserLogin(
        email: email,
        password: password
    );
    Token token = await getToken(userLogin);
    devtools.log(token.access);
    User user = User(
      id: 0,
      email: email,
      token: token.access,
    );
    devtools.log('User has been created Successfully');
    return user;
  }

  Future<void> persistToken ({
    required User user
  }) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future <void> deleteToken({
    required int id
  }) async {
    await userDao.deleteUser(id);
  }

  Future <bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }
}
