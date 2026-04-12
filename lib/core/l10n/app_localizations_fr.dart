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

  @override
  String get tabSettings => 'Paramètres';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get errorGeneric => 'Oups ! Quelque chose a mal tourné.';

  @override
  String get tooltipRefresh => 'Rafraîchir';

  @override
  String addedToFavorites(String movieTitle) {
    return '$movieTitle ajouté aux favoris';
  }

  @override
  String removedFromFavorites(String movieTitle) {
    return '$movieTitle retiré des favoris';
  }
}
