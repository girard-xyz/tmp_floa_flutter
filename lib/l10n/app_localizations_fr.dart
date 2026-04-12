// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Movie Explorer';

  @override
  String get tabPopular => 'Films Populaires';

  @override
  String get tabFavorites => 'Favoris';

  @override
  String get noMoviesFound => 'Aucun film trouvé.';

  @override
  String get noFavoritesYet => 'Vos films favoris apparaîtront ici.';

  @override
  String get errorOccurred => 'Une erreur est survenue.';

  @override
  String get retryButton => 'Réessayer';

  @override
  String get offlineError => 'Hors ligne et aucun cache disponible.';
}
