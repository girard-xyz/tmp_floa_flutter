import 'package:flutter/material.dart';
import 'package:movie_explorer/core/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_bloc.dart';
import 'package:movie_explorer/presentation/blocs/popular_movies/popular_movies_event.dart';
import 'package:movie_explorer/presentation/views/popular_movies_view.dart';
import 'package:movie_explorer/presentation/views/favorites_view.dart';
import 'package:movie_explorer/presentation/views/settings_view.dart';

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

  String _getAppTitle(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return AppLocalizations.of(context)!.tabPopular;
      case 1:
        return AppLocalizations.of(context)!.tabFavorites;
      case 2:
        return AppLocalizations.of(context)!.tabSettings;
      default:
        return AppLocalizations.of(context)!.appTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppTitle(context)),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: AppLocalizations.of(context)!.tooltipRefresh,
              onPressed: () {
                context.read<PopularMoviesBloc>().add(FetchPopularMovies());
              },
            ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [PopularMoviesView(), FavoritesView(), SettingsView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
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
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.tabSettings,
          ),
        ],
      ),
    );
  }
}
