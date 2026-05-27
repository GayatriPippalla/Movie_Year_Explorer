import 'package:hive/hive.dart';

class LocalStorageService {

  final Box box = Hive.box('favorites');

  List<String> getFavorites() {

    return List<String>.from(
      box.get('movieIds', defaultValue: []),
    );
  }

  void saveFavorites(List<String> ids) {

    box.put('movieIds', ids);
  }
}