// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Movie Explorer';

  @override
  String get tabPopular => 'Popular Movies';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get noMoviesFound => 'No movies found.';

  @override
  String get noFavoritesYet => 'Your favorite movies will appear here.';

  @override
  String get errorOccurred => 'An error occurred.';

  @override
  String get retryButton => 'Retry';

  @override
  String get offlineError => 'Offline and no cache available.';

  @override
  String get tabSettings => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get errorGeneric => 'Oops! Something went wrong.';

  @override
  String get tooltipRefresh => 'Refresh';

  @override
  String addedToFavorites(String movieTitle) {
    return '$movieTitle added to favorites';
  }

  @override
  String removedFromFavorites(String movieTitle) {
    return '$movieTitle removed from favorites';
  }
}
