import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In fr, this message translates to:
  /// **'Movie Explorer'**
  String get appTitle;

  /// No description provided for @tabPopular.
  ///
  /// In fr, this message translates to:
  /// **'Films Populaires'**
  String get tabPopular;

  /// No description provided for @tabFavorites.
  ///
  /// In fr, this message translates to:
  /// **'Favoris'**
  String get tabFavorites;

  /// No description provided for @noMoviesFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun film trouvé.'**
  String get noMoviesFound;

  /// No description provided for @noFavoritesYet.
  ///
  /// In fr, this message translates to:
  /// **'Vos films favoris apparaîtront ici.'**
  String get noFavoritesYet;

  /// No description provided for @errorOccurred.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue.'**
  String get errorOccurred;

  /// No description provided for @retryButton.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retryButton;

  /// No description provided for @offlineError.
  ///
  /// In fr, this message translates to:
  /// **'Hors ligne et aucun cache disponible.'**
  String get offlineError;

  /// No description provided for @tabSettings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get tabSettings;

  /// No description provided for @settingsLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get settingsTheme;

  /// No description provided for @themeLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get themeSystem;

  /// No description provided for @errorGeneric.
  ///
  /// In fr, this message translates to:
  /// **'Oups ! Quelque chose a mal tourné.'**
  String get errorGeneric;

  /// No description provided for @tooltipRefresh.
  ///
  /// In fr, this message translates to:
  /// **'Rafraîchir'**
  String get tooltipRefresh;

  /// No description provided for @addedToFavorites.
  ///
  /// In fr, this message translates to:
  /// **'{movieTitle} ajouté aux favoris'**
  String addedToFavorites(String movieTitle);

  /// No description provided for @removedFromFavorites.
  ///
  /// In fr, this message translates to:
  /// **'{movieTitle} retiré des favoris'**
  String removedFromFavorites(String movieTitle);

  /// No description provided for @a11yMovieCardDetail.
  ///
  /// In fr, this message translates to:
  /// **'Film: {movieTitle}, sorti en {movieYear}'**
  String a11yMovieCardDetail(String movieTitle, String movieYear);

  /// No description provided for @a11yAddFavorite.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter aux favoris'**
  String get a11yAddFavorite;

  /// No description provided for @a11yRemoveFavorite.
  ///
  /// In fr, this message translates to:
  /// **'Retirer des favoris'**
  String get a11yRemoveFavorite;

  /// No description provided for @a11yFavoriteButton.
  ///
  /// In fr, this message translates to:
  /// **'Bouton de favoris'**
  String get a11yFavoriteButton;

  /// No description provided for @a11yMovieBackdrop.
  ///
  /// In fr, this message translates to:
  /// **'Arrière plan du film {movieTitle}'**
  String a11yMovieBackdrop(String movieTitle);

  /// No description provided for @a11yMoviePoster.
  ///
  /// In fr, this message translates to:
  /// **'Affiche du film {movieTitle}'**
  String a11yMoviePoster(String movieTitle);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
