# Movie Explorer

Application Flutter de découverte de films, développée selon les principes de la Clean Architecture. L'application inclut la persistance de données (Sqflite), la gestion multi-thèmes et le multi-langues.

## Fonctionnalités Principales

- Films Populaires : Défilement avec pagination automatique utilisant l'API TMDB.
- Favoris : Sauvegarde des films pour consultation hors-ligne avec base de données locale.
- Thème Dynamique (Material 3) : Choix entre Mode Sombre, Mode Clair ou détection du système via SegmentedButton.
- Internationalisation (i18n) : Prise en charge du Français et de l'Anglais, avec sauvegarde des préférences de langue.
- Stratégie Cache Avancée (Offline First) : Conservation locale des images physiques en mémoire et interception des requêtes API (Dio) par stockage persistant pour une consultation sans réseau.
- Accessibilité : Implémentation de Semantics pour l'interface et la compatibilité VoiceOver/TalkBack.

## Architecture & Choix Techniques

L'application repose sur la Clean Architecture (Inversion de Dépendances) afin de conserver une séparation des responsabilités :

1. Couche Domain (lib/domain/) : Contient les entités métiers (ex: Movie), les interfaces de Repositories, et les Use Cases ayant une seule responsabilité métier (ex: GetPopularMoviesUseCase). Ne contient aucune dépendance liée à Flutter ou aux frameworks externes.
2. Couche Data (lib/data/) : Responsable de l'implémentation. Elle exécute et route les requêtes réseaux (TMDB) ou interroge la base locale (SQLite). Cette séparation permet d'interchanger les sources de données sans impacter la logique métier.
3. Couche Presentation (lib/presentation/) : Gère l'interface utilisateur et s'abonne aux changements d'état poussés par la couche métier.

### Sélections Techniques :

- Gestion d'état (BLoC) : L'utilisation de flutter_bloc gère l'état de chaque fonctionnalité de façon isolée (FavoritesBloc, PopularMoviesBloc, SettingsBloc). Cela permet de séparer formellement les évènements de l'interface des données générées.
- Injection de Dépendances (GetIt) : L'initialisation asynchrone des UseCases et Repositories est isolée dans un localisateur. Ce choix évite d'alourdir l'arbre de Context Flutter (comparé à RepositoryProvider) et favorise une configuration de tests isolés.
- Networking (Dio & Retrofit) : Application conjointe de Dio et Retrofit pour isoler, sérialiser et typer formellement les appels HTTP (JSON to Dart).
- Persistance & Séparation du Cache :
  - Sqflite : Exclusivement dédié aux données relationnelles générées par l'utilisateur (Sauvegarde des Favoris et Paramètres). L'ajout de sqflite_common_ffi_web garantit l'interfaçage sur le navigateur.
  - Dio Cache Interceptor (HiveStore) : Intercepte nativement les flux API JSON de TMDB. En cas de coupure de réseau, l'application substitue la limitation Socket par le flux périmé mis en cache, sans polluer Sqflite avec des variables temporaires.
  - Image Cache : Utilisation de cached_network_image pour la restitution locale des posters.
- UI Globale : L'enregistrement du ScaffoldMessenger et des thèmes directement dans le bloc du MaterialApp permet le renvoi d'événements et de Snackbars d'information sans passage manuel du contexte de routage.

## Lancement & Installation

Cibles supportées : Web, iOS, Android.

1. Récupérer les dépendances :
   ```bash
   flutter pub get
   ```

2. Régénérer le code :
   ```bash
   flutter gen-l10n
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. Lancement (exemple Web) :
   ```bash
   flutter run -d chrome
   ```

4. Exécuter les tests unitaires natifs :
   ```bash
   flutter test
   ```

## Stack Technique
- Framework : Flutter
- State Management : flutter_bloc
- Networking : dio, retrofit
- Base de Données / Persistance : sqflite, sqflite_common_ffi_web
- Système de Cache : dio_cache_interceptor (Hive Store), cached_network_image
- L10N : flutter_localizations
- Data : json_serializable, json_annotation
