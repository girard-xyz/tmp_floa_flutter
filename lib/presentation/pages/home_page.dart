import 'package:flutter/material.dart';
import 'package:movie_explorer/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies_event.dart';
import 'package:movie_explorer/presentation/views/popular_movies_view.dart';
import 'package:movie_explorer/presentation/views/favorites_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Au lancement, on déclenche l'événement pour récupérer les films
    context.read<PopularMoviesBloc>().add(FetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515), // Fond sombre plus élégant
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? AppLocalizations.of(context)!.tabPopular
              : AppLocalizations.of(context)!.tabFavorites,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF151515),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Le bouton refresh n'a de sens que sur l'onglet API
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Rafraîchir',
              onPressed: () {
                context.read<PopularMoviesBloc>().add(FetchPopularMovies());
              },
            ),
        ],
      ),
      // IndexedStack permet de garder l'état de la grille (scroll) intact quand on change d'onglet
      body: IndexedStack(
        index: _currentIndex,
        children: const [PopularMoviesView(), FavoritesView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF151515),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: AppLocalizations.of(context)!.tabPopular,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: AppLocalizations.of(context)!.tabFavorites,
          ),
        ],
      ),
    );
  }
}
