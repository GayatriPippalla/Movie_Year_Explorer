import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:movie_year_explorer/features/users/data/parsers/user_parser.dart';
import 'package:movie_year_explorer/features/users/data/models/user_model.dart';

class UserRepository {
  final Dio dio;

  UserRepository(this.dio);

  Future<List<UserModel>> getUsers() async {
    final response = await dio.get('/users');

    final responseBody =
        response.data is String ? response.data as String : jsonEncode(response.data);

    final users = await compute(
      parseUsers,
      responseBody,
    );

    return users;
  }
}

