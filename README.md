# Movie Year Explorer

Movie Year Explorer is a Flutter app that lets you search movies by **release year**, view results with **pagination**, open **movie details** (via IMDb ID), and mark movies as **favorites**.

The app uses the **OMDb API** (`https://www.omdbapi.com`) with endpoints for:
- Searching movies by title/year (OMDb `s` query)
- Getting full movie details by IMDb ID (OMDb `i` query)

---

## Features
- ✅ Search movies by **4-digit release year**
- ✅ Debounced search input (prevents excessive requests)
- ✅ Pagination (infinite scroll near the bottom)
- ✅ Movie details page (poster, plot, actors, ratings, etc.)
- ✅ Favorite/unfavorite movies (heart icon)

---

## Tech Stack
- Flutter / Dart
- dio (HTTP client)
- retrofit (API client generation)
- provider (state management)
- get_it (dependency injection support)

---

## Project Structure (high level)
- `lib/screens/`
  - `home_screen.dart` — search + results list + favorites
  - `movie_details_screen.dart` — movie details by IMDb ID
- `lib/viewmodels/`
  - `movie_viewmodel.dart` — search, pagination, favorites, debounce
- `lib/repositories/`
  - `movie_repository.dart` — coordinates service calls
- `lib/services/`
  - `movie_service.dart` — OMDb endpoints (retrofit)
- `lib/models/`
  - `movie_model.dart`, `movie_response.dart`, `movie_details_model.dart`
- `lib/core/constants/`
  - `api_constants.dart` — OMDb base URL + API key

---

## Setup / Run Locally

### 1) Install dependencies
```bash
flutter pub get
```

### 2) Run the app
```bash
flutter run
```

---

## API Configuration Notes
OMDb configuration is in:
- `lib/core/constants/api_constants.dart`

It currently contains:
- `baseUrl = https://www.omdbapi.com`
- `apiKey = ...`

To use your own OMDb API key, replace `ApiConstants.apiKey`.

---

## How to Use
1. On the Home screen, type a **4-digit year** (example: `2020`).
2. Results load automatically after a short debounce delay.
3. Scroll down to load more results (pagination).
4. Tap a movie card to open the Movie Details screen.
5. Use the heart icon to add/remove from favorites.

---

## License
Add your preferred license information here (or remove this section if not needed).

