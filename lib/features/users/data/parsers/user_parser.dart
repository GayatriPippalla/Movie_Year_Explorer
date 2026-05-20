import 'dart:convert';
import '../models/user_model.dart';

List<UserModel> parseUsers(String responseBody) {

  final parsed = jsonDecode(responseBody);

  return (parsed as List)
      .map<UserModel>(
        (json) => UserModel.fromJson(json),
      )
      .toList();
}