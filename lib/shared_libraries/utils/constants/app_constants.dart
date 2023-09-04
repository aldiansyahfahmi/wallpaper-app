class AppConstants {
  const AppConstants();

  static AppApi appApi = const AppApi();
  static ErrorKey errorKey = const ErrorKey();
}

class AppApi {
  const AppApi();
  String get token =>
      'ct0wMETCWQHgYGKYIMarZb0GYancKAca3oVPqepJOb1w6U1VvtIALe0B';
  String get baseUrlDevelopment => 'https://api.pexels.com/v1/';
  String get baseUrlProduction => 'https://api.pexels.com/v1/';

  String get curated => 'curated';
  String get search => 'search?query=';
}

class ErrorKey {
  const ErrorKey();

  String get message => "message";
}
