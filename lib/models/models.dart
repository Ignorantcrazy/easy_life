import 'dart:io';

class Models {
  final String apiBaseUrl;
  final String resBaseUrl;

  Models(this.apiBaseUrl, this.resBaseUrl);
}

typedef Strings2VoidFunc = void Function(String, String);

typedef String2VoidFunc = void Function(String);

typedef File2VoidFunc = void Function(File);

typedef bool2VoidFunc = void Function(bool);