# Movie Year Explorer

Movie Year Explorer is a Flutter app that lets you search movies by **release year**, view results with **pagination**, open **movie details** (by IMDb ID), and mark movies as **favorites**.

Data source: **OMDb API** (`https://www.omdbapi.com`).
- Search by title/year (OMDb `s` query)
- Fetch details by IMDb ID (OMDb `i` query)

---

## Features
- ✅ Search by **4-digit release year**
- ✅ Debounced search input (reduces API calls)
- ✅ Pagination (loads more when scrolling near the bottom)
- ✅ Movie details screen (poster, plot, actors, ratings, etc.)
- ✅ Favorites (add/remove via heart icon, persisted locally)

---

## Tech Stack
- Flutter / Dart
- dio (HTTP client)
- retrofit (API client generation)
- provider / ChangeNotifier (view model state)
- flutter_riverpod (screen-level consumption)
- get_it (dependency injection scaffolding)
- Hive (local persistence)

---

## Key Files (High Level)
- `lib/screens/home_screen.dart`
  - Year input, results list, infinite scroll, favorites UI
- `lib/screens/movie_details_screen.dart`
  - Fetches and renders full movie details for a given `imdbId`
- `lib/viewmodels/movie_viewmodel.dart`
  - Search + pagination + debounce + favorites state
- `lib/repositories/movie_repository.dart`
  - Orchestrates service calls
- `lib/services/movie_service.dart`
  - OMDb endpoints (retrofit)
- `lib/core/constants/api_constants.dart`
  - OMDb base URL + API key

---

## Setup / Run Locally
1) Install dependencies:
```bash
flutter pub get
```

2) Run:
```bash
flutter run
```

---

## OMDb API Configuration
OMDb config lives in:
- `lib/core/constants/api_constants.dart`

This project uses:
- `ApiConstants.baseUrl = https://www.omdbapi.com`
- `ApiConstants.apiKey = <your key>`

To use your own OMDb API key, replace `ApiConstants.apiKey`.

---

## How to Use
1. Enter a **4-digit year** (e.g. `2020`) on the Home screen.
2. Results load automatically after a short debounce delay.
3. Scroll down to load more results.
4. Tap a movie card to open the Movie Details screen.
5. Use the heart icon to add/remove favorites.



