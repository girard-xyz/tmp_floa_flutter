# 🎬 Movie Explorer

Une application Flutter professionnelle de découverte de films, construite selon les principes rigoureux de la **Clean Architecture**. L'application offre une expérience utilisateur fluide, magnifique et hors ligne grâce au support complet de la persistance de données (Sqflite), du multi-thèmes et du multi-langues.

## ✨ Fonctionnalités Principales

- **🍿 Films Populaires :** Défilez de manière infinie à travers les tendances mondiales du cinéma (Source TMDB API). La pagination est invisible et rechargée automatiquement pour une fluidité sans accroc.
- **❤️ Favoris :** Sauvegardez vos films préférés en mode hors-ligne. Votre bibliothèque personnelle s'alimente et se gère en un clin d'œil.
- **🌙 Thème Dynamique (Material 3) :** Switcher instantanément entre le Mode Sombre élégant, le Mode Clair ou la détection Automatique du Système via une interface épurée s'appuyant sur les nouveaux `SegmentedButton` de Material 3.
- **🌍 Internationalisation Intégrée (i18n) :** Changez la langue de l'application (Français / English) à la volée, le tout sauvegardé dans la mémoire locale.
- **💾 Persistance Robuste :** Aucune connexion Internet ? L'application charge vos films précédemment vus depuis le cache **Sqflite** et maintient l'ensemble de vos paramètres système intacts !

---

## 🏗 Architecture & Codebase

Cette application a été méticuleusement conçue autour du paradigme **Clean Architecture** strict avec une séparation ferme des dossiers :

1. **Couche Domain (`lib/domain/`)** : Cœur métier de l’application. Contient nos Entités (e.g. `Movie`), nos Repositories Abstraits, et l'ensemble de nos Use Cases limités à une responsabilité unique (`GetPopularMoviesUseCase`). Zéro dépendance à Flutter.
2. **Couche Data (`lib/data/`)** : Gère l'apport en données. Comprend l'implémentation du `MovieRepository`, l'appel HTTP via `Dio` & `Retrofit` sur l’API TMDB, et la base de données SQL locale branchée à `Sqflite`.
3. **Couche Presentation (`lib/presentation/`)** : Tout ce qui a trait à l'interface. 
   - L'état de l'interface est soutenu par **Flutter BLoC** (via `Cubit` / `Bloc` Events, States complets isolés par feature : `favorites`, `popular_movies`, `settings`).
   - L'UI est rendue à travers une série de Vues et Widgets réactifs.

### Standards de Code :
- Variables et typages **explicites** (pas de variables cryptiques `e`, `m`, etc).
- Seuls les **imports package absolus** sont utilisés dans le projet pour une robustesse face au refactoring (e.g. `import 'package:movie_explorer/core...'`).
- Tests Unitaire 100% natifs (Zéro librairie de *Mock* tierce ajoutée : conception interne de `Fakes` propres et autonomes).

---

## 🚀 Lancement & Installation

Ce projet ne vise que des cibles optimisées : **Web, iOS, et Android**.

1. **Récupérer les dépendances :**
   ```bash
   flutter pub get
   ```

2. **(Optionnel) Regénérer le code :**
   Si vous touchez aux fichiers `.arb` pour les traductions ou aux classes Json (Retrofit) :
   ```bash
   flutter gen-l10n
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Lancer sur le Web (Chrome) :**
   ```bash
   flutter run -d chrome
   ```
   *(La base de données Sqflite est automatiquement branchée sur sqflite_common_ffi_web pour s'assurer que la persistance tourne sans accroc sur navigateur !)*

4. **Lancer les Tests :**
   La suite de tests unitaires (Usecases, Blocs, et Mappers Data) s'exécute nativement :
   ```bash
   flutter test
   ```

---

## 🛠 Stack Technique
- **Framework :** Flutter (Canaux stables)
- **State Management :** `flutter_bloc`
- **Networking :** `dio`, `retrofit`
- **Base de Données / Persistance :** `sqflite`, `sqflite_common_ffi_web`
- **i18n :** `flutter_localizations`
- **Data Models :** `json_serializable`, `json_annotation`
- **Code Quality :** Test unitaires Flutter natifs.
