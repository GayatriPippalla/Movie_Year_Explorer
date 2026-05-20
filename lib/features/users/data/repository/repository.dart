import 'package:flutter/foundation.dart';

Future<List<UserModel>> getUsers() async {

  final response = await dio.get('/users');

  final users = await compute(
    parseUsers,
    response.data,
  );

  return users;
}