// import 'dart:convert';
//yo maile http use gardac rakheko but i switchedx to dio

// import '../../../core/config/api_config.dart';

// class AuthApiService {
//   final http.Client _client;
//   AuthApiService({http.Client? client}) : _client = client ?? http.Client();

//   Future<void> signup({
//     required String name,
//     required String email,
//     required String password,
//     required String batchId,
//     String? username,
//     String phoneNumber = "9800000000",
//   }) async {
//     final uri = Uri.parse(ApiConfig.signup);

//     final body = {
//       "name": name,
//       "username": username ?? name,
//       "email": email,
//       "password": password,
//       "phoneNumber": phoneNumber,
//       "batchId": batchId,
//     };

//     final res = await _client.post(
//       uri,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode(body),
//     );

//     if (res.statusCode == 200 || res.statusCode == 201) return;

//     throw Exception(_extractMessage(res.body) ?? "Signup failed");
//   }

//   Future<String> login({
//     required String email,
//     required String password,
//   }) async {
//     final uri = Uri.parse(ApiConfig.login);

//     final res = await _client.post(
//       uri,
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"email": email, "password": password}),
//     );

//     if (res.statusCode == 200) {
//       final decoded = jsonDecode(res.body) as Map<String, dynamic>;
//       final token = decoded["token"] as String?;
//       if (token == null || token.isEmpty) {
//         throw Exception("Token missing in response");
//       }
//       return token;
//     }

//     throw Exception(_extractMessage(res.body) ?? "Login failed");
//   }

//   String? _extractMessage(String raw) {
//     try {
//       final decoded = jsonDecode(raw);
//       if (decoded is Map<String, dynamic>) {
//         return decoded["message"]?.toString();
//       }
//       return null;
//     } catch (_) {
//       return null;
//     }
//   }
// }
