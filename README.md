# Explorateur de Films - Test Technique

Ce projet est une application Flutter développée dans le cadre d'un test technique. Il permet aux utilisateurs de parcourir un catalogue de films, d'afficher leurs détails, et de sauvegarder leurs favoris pour un accès hors-ligne.

## Objectifs

* Afficher un catalogue de films.
* Consulter les détails d'un film.
* Gérer les favoris avec sauvegarde hors-ligne.
* Mettre en valeur la Clean Architecture, une base de code maintenable et lisible, et l'usage de tests unitaires / objets métiers.

## Architecture : Clean Architecture

Pour garantir une séparation nette des responsabilités, la base de code suit les principes de la **Clean Architecture**, répartie en trois couches principales :

1. **Domain (`lib/domain/`)** : Le cœur de l'application. Cette couche est indépendante de tout framework tiers. Elle contient les Entités (`Movie`), les contrats d'accès aux données (`MovieRepository`), et les Cas d'Usage (`GetMoviesUseCase`, `ToggleFavoriteUseCase`).
2. **Data (`lib/data/`)** : Implémente le contrat du domaine. Elle est en charge d'interagir avec les bases de données (hors-ligne) et le réseau. Elle intègre également les DTO (`MovieDto`) et les Transformers (Mappers) pour faire le pont avec la couche Domain. 
3. **Presentation (`lib/presentation/`)** : S'occupe de l'Interface Utilisateur (UI) et de la gestion fine des états avec **BLoC** (Business Logic Component).

## Choix Techniques & Librairies

Afin de rester focalisé sur le code métier et démontrer la flexibilité de base, l'utilisation de librairies externes a été réduite au strict nécessaire :
* **State Management** : `flutter_bloc` pour gérer les événements et changements d'états asynchrones dans l'interface graphique.
* **Égalité d'objets** : `equatable` est utilisé sur les Entités et les États afin de faciliter grandement les comparaisons de valeurs pour les tests et la logique BLoC.
* **Tests unitaires** : Utilisation du module natif `flutter_test` de façon manuelle. L'utilisation de faux objets (Mock) "fait main" évite la surcharge du répertoire par des générateurs massifs (comme `mockito`/`build_runner`).

## Lancement du Projet

Assurez-vous d'avoir Flutter configuré, puis exécutez les commandes suivantes :

```bash
flutter pub get
flutter run
```

## Lancement des tests

Les différents tests sur la couche "Domain" et le "DTO" Data sont exécutables avec la commande :
```bash
flutter test
```
