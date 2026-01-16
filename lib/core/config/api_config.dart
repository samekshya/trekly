class ApiConfig {
  // Android emulator uses 10.0.2.2 to reach your PC's localhost
  static const String baseUrl = "http://10.0.2.2:3000/api/v1";

  static const String signup = "$baseUrl/students";
  static const String login = "$baseUrl/students/login";
}
