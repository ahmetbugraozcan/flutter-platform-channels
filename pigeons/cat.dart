import 'package:pigeon/pigeon.dart';

class Cat {
  String? name;
  int? age;
}

@HostApi()
abstract class CatApi {
  List<Cat?> getCats();
}
