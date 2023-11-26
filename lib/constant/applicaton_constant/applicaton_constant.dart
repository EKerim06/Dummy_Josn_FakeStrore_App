/// [ApplicationConstant] is a class that contains
/// all the constant values used in the application.
class ApplicationConstant {
  ApplicationConstant._init();

  static ApplicationConstant? _instance;

  static ApplicationConstant get instance {
    _instance ??= ApplicationConstant._init();
    return _instance!;
  }

  final String baseUrl = 'https://dummyjson.com/';
}
