import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/l10n/app_localizations.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_bloc.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_event.dart';
import 'package:movie_explorer/presentation/blocs/settings/settings_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- Carte Langue ---
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.language, color: Colors.amber.shade300),
                        const SizedBox(width: 12),
                        Text(
                          loc.settingsLanguage,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(value: 'fr', label: Text('Français')),
                        ButtonSegment(value: 'en', label: Text('English')),
                      ],
                      selected: {state.rawLanguage},
                      onSelectionChanged: (Set<String> newSelection) {
                        context.read<SettingsBloc>().add(
                          ChangeLanguage(newSelection.first),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.amber.shade300;
                            }
                            return Colors.transparent;
                          },
                        ),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.black;
                            }
                            return colorScheme.onSurface;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- Carte Thème ---
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.color_lens, color: Colors.amber.shade300),
                        const SizedBox(width: 12),
                        Text(
                          loc.settingsTheme,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SegmentedButton<String>(
                      segments: [
                        ButtonSegment(
                          value: 'system',
                          icon: const Icon(Icons.brightness_auto),
                          label: Text(loc.themeSystem),
                        ),
                        ButtonSegment(
                          value: 'light',
                          icon: const Icon(Icons.light_mode),
                          label: Text(loc.themeLight),
                        ),
                        ButtonSegment(
                          value: 'dark',
                          icon: const Icon(Icons.dark_mode),
                          label: Text(loc.themeDark),
                        ),
                      ],
                      selected: {state.rawTheme},
                      onSelectionChanged: (Set<String> newSelection) {
                        context.read<SettingsBloc>().add(
                          ChangeTheme(newSelection.first),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.amber.shade300;
                            }
                            return Colors.transparent;
                          },
                        ),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.black;
                            }
                            return colorScheme.onSurface;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
