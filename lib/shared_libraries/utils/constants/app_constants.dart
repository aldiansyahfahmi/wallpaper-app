class AppConstants {
  const AppConstants();

  static App app = const App();
  static CachedKey cachedKey = const CachedKey();
  static AppApi appApi = const AppApi();
  static ErrorKey errorKey = const ErrorKey();
  static ErrorMessage errorMessage = const ErrorMessage();
}

class App {
  const App();

  double get defaultMargin => 16.0;
}

class CachedKey {
  const CachedKey();

  String get tokenKey => 'tokenKey';
}

class AppApi {
  const AppApi();
  String get token =>
      'ct0wMETCWQHgYGKYIMarZb0GYancKAca3oVPqepJOb1w6U1VvtIALe0B';
  String get baseUrlDevelopment => 'https://api.pexels.com/v1/';
  String get baseUrlProduction => 'https://api.pexels.com/v1/';

  String get curated => 'curated';
}

class ErrorKey {
  const ErrorKey();

  String get message => "message";
}

class ErrorMessage {
  const ErrorMessage();

  String get failedGetToken => 'failed get token';
}
