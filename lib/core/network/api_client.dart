// This file is intentionally kept as the app-level API entry point.
//
// NOTE:
// The current Movies feature uses Retrofit directly via `MovieService`
// (see `lib/services/movie_service.dart`), and the app is wired in
// `lib/main.dart` using `DioClient().dio`.
//
// If you later want a centralized API client (e.g., multiple Retrofit
// services or shared interceptors), implement it here.
//
// Keeping this file non-empty prevents accidental import/analysis issues.

class ApiClient {
  const ApiClient();
}

