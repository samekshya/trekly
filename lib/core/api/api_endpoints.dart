class ApiEndpoints {
  // base URL for Android emulator
  static const String baseUrl = "http://10.0.2.2:5050/api";

  // Auth
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String me = "/auth/me";
  static const String logout = "/auth/logout";
  static const String forgotPassword = "/auth/forgot-password";
  static const String resetPassword = "/auth/reset-password";
  static String updateProfile(String id) => "/auth/$id";

  // Treks
  static const String treks = "/treks";
  static String trekById(String id) => "/treks/$id";
  static String bookTrek(String id) => "/treks/$id/book";

  // Favourites
  static const String favourites = "/favourites";
  static String removeFavourite(String id) => "/favourites/$id";
  static String checkFavourite(String id) => "/favourites/check/$id";

  // Bookings
  static const String myBookings = "/bookings/my";

  // Reviews
  static String reviews(String trekId) => "/reviews/$trekId";
  static String canReview(String trekId) => "/reviews/$trekId/can-review";

  // Weather
  static String weather(String location) => "/weather/$location";
}
